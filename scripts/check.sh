#!/usr/bin/env bash
#
# check.sh - Consistency checks of the repository (scripts, tasks, skills, links).
#
# Usage:
#   scripts/check.sh          Run all checks
#   scripts/check.sh help     Show this help
#
# Checks (the IDs are those of the skill perform-qa-measurements):
#   QA-2  Every scripts/*.sh has valid Bash syntax and is executable.
#   QA-3  scripts/tasks.sh list -deps reads every task file in aitasks/.
#   QA-4  Every task dependency names an existing task; the dependencies contain no cycle.
#   QA-5  Every skills/*/SKILL.md has a "name" equal to its directory and a "description",
#         every skill is listed in the skills table of AGENTS.md, and .claude/skills
#         links to ../skills.
#   QA-6  Every relative link in a Markdown file points to an existing file.
#
# Prints one line per check (OK or FAIL) followed by the findings of failed checks.
# Does not change any file. Exits with 1 if a check failed.

# Note for developers: the comment block above is printed by "help".
# Keep this script compatible with Bash 3.2 (see doc/developerInfrastructure.md).
# Add tests for every new check to scripts/test.sh.

set -u

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_DIR" || exit 1

usage() {
    awk '
        NR == 1 { next }
        !/^#/   { exit }
        { sub(/^# ?/, ""); if (started || $0 != "") { started = 1; print } }
    ' "${BASH_SOURCE[0]}"
}

case "${1:-}" in
    "") ;;
    help|-h|--help) usage; exit 0 ;;
    *) echo "Error: unknown argument '$1' (see: scripts/check.sh help)" >&2; exit 2 ;;
esac

FAILED=0

# report ID TITLE FINDINGS: prints the result of one check; findings make it fail.
report() {
    if [ -z "$3" ]; then
        echo "OK    $1  $2"
    else
        echo "FAIL  $1  $2"
        printf '%s\n' "$3" | sed 's/^/        /'
        FAILED=1
    fi
}

# QA-2: syntax and permissions of the scripts
check_scripts() {
    local f out=""
    for f in scripts/*.sh; do
        [ -e "$f" ] || continue
        bash -n "$f" 2>/dev/null || out="$out${out:+
}syntax error: $f"
        [ -x "$f" ] || out="$out${out:+
}not executable: $f"
    done
    report QA-2 "Syntax and permissions of the scripts" "$out"
}

# QA-3: task files are readable
check_task_files() {
    local out listed files
    if ! out="$(scripts/tasks.sh list -deps 2>&1)"; then
        report QA-3 "Task files are readable" "$out"
        return
    fi
    listed=$(($(printf '%s\n' "$out" | wc -l) - 1))
    files=$(find aitasks -maxdepth 1 -name '*.md' 2>/dev/null | wc -l)
    if [ "$listed" -ne "$files" ]; then
        report QA-3 "Task files are readable" "$files task files, but $listed tasks listed"
    else
        report QA-3 "Task files are readable" ""
    fi
}

# QA-4: task dependencies exist and contain no cycle
check_task_dependencies() {
    local out
    out="$(python3 -I - <<'EOF' 2>&1
import re, pathlib
tasks, bad = {}, []
for f in sorted(pathlib.Path('aitasks').glob('*.md')):
    t = f.read_text(encoding='utf-8')
    m_id = re.search(r'^\| \*\*ID\*\* +\| *(\S+)', t, re.M)
    m_dep = re.search(r'^\| \*\*Dependencies\*\* +\|([^|]*)\|', t, re.M)
    if not m_id or not m_dep:
        bad.append(f'{f}: no ID or Dependencies row')
        continue
    deps = re.sub(r'<!--.*?-->', '', m_dep.group(1)).strip()
    tasks[m_id.group(1)] = [] if deps.lower() in ('', 'none') else [d.strip() for d in deps.split(',')]
bad += [f'{t}: unknown dependency {d}' for t, ds in tasks.items() for d in ds if d not in tasks]
state = {}
def visit(t, path):
    if state.get(t) == 'done':
        return
    if state.get(t) == 'active':
        bad.append('cycle: ' + ' -> '.join(path[path.index(t):] + [t]))
        return
    state[t] = 'active'
    for d in tasks.get(t, []):
        visit(d, path + [t])
    state[t] = 'done'
for t in tasks:
    visit(t, [])
print('\n'.join(bad))
EOF
)"
    report QA-4 "Task dependencies are valid" "$out"
}

# QA-5: skills are well-formed and registered
check_skills() {
    local d n out=""
    for d in skills/*/; do
        [ -d "$d" ] || continue
        n="$(basename "$d")"
        if ! grep -q "^name: $n\$" "$d/SKILL.md" 2>/dev/null ||
           ! grep -q '^description: ..' "$d/SKILL.md" 2>/dev/null; then
            out="$out${out:+
}bad frontmatter: $d""SKILL.md"
        fi
        grep -q "^| \`$n\`" AGENTS.md 2>/dev/null || out="$out${out:+
}not in the skills table of AGENTS.md: $n"
    done
    [ "$(readlink .claude/skills 2>/dev/null)" = "../skills" ] || out="$out${out:+
}.claude/skills is not a link to ../skills"
    report QA-5 "Skills are well-formed and registered" "$out"
}

# QA-6: relative links in Markdown files
check_links() {
    local out
    out="$(python3 -I - <<'EOF' 2>&1
import re, pathlib
bad = []
for md in sorted(pathlib.Path('.').rglob('*.md')):
    if '.git' in md.parts or '.claude' in md.parts:
        continue
    for target in re.findall(r'\]\(([^)#\s]+)', md.read_text(encoding='utf-8')):
        if '://' not in target and not target.startswith('mailto:') and not (md.parent / target).exists():
            bad.append(f'{md}: {target}')
print('\n'.join(bad))
EOF
)"
    report QA-6 "Links in Markdown files are valid" "$out"
}

check_scripts
check_task_files
check_task_dependencies
check_skills
check_links

exit "$FAILED"
