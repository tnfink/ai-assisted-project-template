#!/usr/bin/env bash
#
# init-project.sh - Turns a fresh clone of the project template into a new project.
#
# Usage:
#   scripts/init-project.sh [--keep-history] [--yes] NAME
#
# NAME             Name of the new project (letters, digits, ".", "_" and "-"; e.g. MyShop)
# --keep-history   Keep the template's git history. The remote "origin" is renamed to
#                  "upstream", so template updates can still be merged later.
#                  Default: the git history is deleted and a new repository is created.
# --yes            Do not ask for confirmation (for non-interactive use)
#
# Steps:
#   1. Renames the IntelliJ module file (*.iml) to NAME.iml and updates .idea/modules.xml.
#   2. Replaces the "About this project" section in AGENTS.md with one for project NAME.
#   3. Resets the git repository (or, with --keep-history, renames origin to upstream)
#      and commits the result.
#
# The working tree must be clean (no uncommitted changes) before running this script.

# Note for developers: the comment block above is printed by --help.
# Keep this script compatible with Bash 3.2 (see doc/developerInfrastructure.md).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
    awk '
        NR == 1 { next }
        !/^#/   { exit }
        { sub(/^# ?/, ""); if (started || $0 != "") { started = 1; print } }
    ' "${BASH_SOURCE[0]}"
}

die() {
    echo "Error: $*" >&2
    exit 1
}

# --- Parse arguments -------------------------------------------------------

NAME=""
KEEP_HISTORY=false
ASSUME_YES=false
while [ $# -gt 0 ]; do
    case "$1" in
        --keep-history) KEEP_HISTORY=true ;;
        --yes)          ASSUME_YES=true ;;
        -h|--help)      usage; exit 0 ;;
        -*)             usage >&2; die "unknown option '$1'" ;;
        *)
            [ -z "$NAME" ] || die "only one NAME allowed"
            NAME="$1"
            ;;
    esac
    shift
done

[ -n "$NAME" ] || { usage >&2; die "NAME is missing"; }
echo "$NAME" | grep -Eq '^[A-Za-z0-9][A-Za-z0-9._-]*$' \
    || die "invalid NAME '$NAME' (use letters, digits, '.', '_' and '-', starting with a letter or digit)"

cd "$REPO_DIR"

# --- Checks ----------------------------------------------------------------

[ -d .git ] || die "$REPO_DIR is not the root of a git repository"
command -v git >/dev/null || die "git is not installed"
if [ -n "$(git status --porcelain)" ]; then
    die "the working tree has uncommitted changes; commit or stash them first"
fi

OLD_IML=""
for file in *.iml; do
    [ -e "$file" ] || continue
    [ -z "$OLD_IML" ] || die "more than one *.iml file found; rename the module manually"
    OLD_IML="$file"
done
NEW_IML="$NAME.iml"

HAS_ORIGIN=false
git remote get-url origin >/dev/null 2>&1 && HAS_ORIGIN=true

# --- Confirm ---------------------------------------------------------------

echo "This will initialize the project '$NAME' in $REPO_DIR:"
if [ -n "$OLD_IML" ] && [ "$OLD_IML" != "$NEW_IML" ]; then
    echo "  - rename $OLD_IML to $NEW_IML and update .idea/modules.xml"
fi
echo "  - replace the 'About this project' section in AGENTS.md"
if $KEEP_HISTORY; then
    if $HAS_ORIGIN; then
        echo "  - rename the git remote 'origin' to 'upstream' ($(git remote get-url origin))"
    fi
    echo "  - commit the changes (git history is kept)"
else
    echo "  - DELETE the git history ($(git rev-list --all --count 2>/dev/null || echo 0) commits) and all remotes,"
    echo "    create a new git repository and make an initial commit"
fi

if ! $ASSUME_YES; then
    [ -t 0 ] || die "no terminal to ask for confirmation; use --yes to proceed without asking"
    printf 'Proceed? [y/N] '
    read -r answer
    case "$answer" in
        y|Y|yes|YES) ;;
        *) echo "Aborted, nothing was changed."; exit 1 ;;
    esac
fi

# --- 1. Rename the IntelliJ module ----------------------------------------

if [ -n "$OLD_IML" ] && [ "$OLD_IML" != "$NEW_IML" ]; then
    mv "$OLD_IML" "$NEW_IML"
    if [ -f .idea/modules.xml ]; then
        OLD="$OLD_IML" NEW="$NEW_IML" awk '
            {
                line = $0; out = ""
                while ((pos = index(line, ENVIRON["OLD"])) > 0) {
                    out = out substr(line, 1, pos - 1) ENVIRON["NEW"]
                    line = substr(line, pos + length(ENVIRON["OLD"]))
                }
                print out line
            }' .idea/modules.xml > .idea/modules.xml.tmp
        mv .idea/modules.xml.tmp .idea/modules.xml
    fi
    echo "Renamed $OLD_IML to $NEW_IML."
fi

# --- 2. Update AGENTS.md ---------------------------------------------------

if [ -f AGENTS.md ]; then
    NAME="$NAME" awk '
        /^## About this project/ {
            print
            print ""
            print "This is the project **" ENVIRON["NAME"] "**. It was created from a template for software"
            print "development projects that rely heavily on an AI coding assistant."
            print "The domain, the problems solved and the features of the application are described in"
            print "`README.md`. Keep this section up to date with project-specific information (purpose,"
            print "tech stack, build and test commands)."
            print ""
            skip = 1
            next
        }
        skip && /^## / { skip = 0 }
        !skip { print }
    ' AGENTS.md > AGENTS.md.tmp
    mv AGENTS.md.tmp AGENTS.md
    echo "Updated AGENTS.md."
fi

# --- 3. Git ----------------------------------------------------------------

if $KEEP_HISTORY; then
    if $HAS_ORIGIN; then
        git remote rename origin upstream
        echo "Renamed remote 'origin' to 'upstream'. Add the new project's remote with:"
        echo "  git remote add origin <URL>"
    fi
    git add -A
    git commit -q -m "Initialize project $NAME from template"
else
    rm -rf .git
    git init -q
    git add -A
    git commit -q -m "Initial commit of project $NAME (created from template)"
    echo "Created a new git repository. Add the project's remote with:"
    echo "  git remote add origin <URL>"
fi

echo "Project '$NAME' initialized."
