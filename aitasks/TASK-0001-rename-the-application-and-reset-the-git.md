# TASK-0001: Rename the application and reset the git repository

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | TASK-0001 |
| **Short description** | Rename the application and reset the git repository |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | none |
| **Dependencies**  | none |

## Motivation

This repository is a template. A project created from it must first get its own name and its
own git repository, otherwise it still carries the template's name (e.g. in the IntelliJ module
file and in `AGENTS.md`) and the template's git history and remote. Doing this as the very first
step ensures that all following tasks work on the new project.

## Task description

1. Ask the user for the name of the new application (letters, digits, `.`, `_` and `-`).
2. Ask the user whether the git history of the template should be
   - **reset** (default): the history and all remotes are deleted and a new repository is
     created, or
   - **kept**: the history is kept and the remote `origin` is renamed to `upstream`, so template
     updates can be merged later.
3. Make sure the working tree has no uncommitted changes.
4. Run `scripts/init-project.sh` with the name, adding `--keep-history` if the user wants to
   keep the history. Show the user the planned changes the script prints and get the user's
   explicit confirmation before running it with `--yes`, because deleting the git history
   cannot be undone.
5. Tell the user to add the remote of the new project with `git remote add origin <URL>`.

Renaming the project directory itself is out of scope; the user chooses it when cloning.

## Acceptance criteria

- [ ] The user has given the application name and decided whether to reset or keep the git
      history.
- [ ] The IntelliJ module file is named `<NAME>.iml` and `.idea/modules.xml` references it.
- [ ] The section "About this project" in `AGENTS.md` names the new project and no longer
      describes the repository as a template.
- [ ] Reset: `git log` shows a single initial commit and `git remote` lists no remotes.
- [ ] Kept history: the remote `origin` has been renamed to `upstream` and the changes are
      committed.
- [ ] `git status` shows no uncommitted changes.

## History

<!--
  Log of all status changes, oldest first. Add a row for every change of the Status field.
  Timestamp format: ISO 8601 with time zone offset, e.g. 2026-11-11T14:30+0100
  (get it with: date +%Y-%m-%dT%H:%M%z).
  Comment: optional, but required for "waiting" and "aborted" (state the reason).
-->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| 2026-11-11T16:55+0100 | open   | Task created  |
