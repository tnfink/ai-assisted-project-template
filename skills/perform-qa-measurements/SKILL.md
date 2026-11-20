---
name: perform-qa-measurements
description: Execute all QA measurements of the project (automated tests, static checks and consistency checks) and report the results. Use when the user asks to run, perform or execute the QA measures, the quality checks or all checks (e.g. before a release or as part of the regular maintenance). Runs the measurements listed in this skill; it does not fix findings.
---

# perform-qa-measurements

Executes every QA measurement of the project and reports the result of each. This is the
activity "Perform QA measures on the code" of the regular maintenance in
`doc/swDevelopmentProcess.md`.

The skill only measures: it does not change code, documents or tasks. Findings are reported and
turned into fixes or tasks with the user's consent.

## Measurements

The table lists all measurements of the project. It starts with the measurements of the
template itself. **TASK-0007** adapts it to the QA measures decided in `doc/qameasures.md`:
every decided measure gets a row, and the template measurements that still apply stay. A
measure whose implementation task is not yet `done` is listed with the status
`planned (TASK-<NNNN>)` and skipped; that task sets it to `active` and fills in its command.

| ID   | Measurement                           | Command            | Passes when                    | Status |
|------|---------------------------------------|--------------------|--------------------------------|--------|
| QA-1 | Tests of the scripts                  | `scripts/test.sh`  | exit code 0, "0 failed"        | active |
| QA-2 | Syntax and permissions of the scripts | `scripts/check-consistency.sh` | its line for QA-2 starts with `OK` | active |
| QA-3 | Task files are readable               | `scripts/check-consistency.sh` | its line for QA-3 starts with `OK` | active |
| QA-4 | Task dependencies exist and contain no cycle | `scripts/check-consistency.sh` | its line for QA-4 starts with `OK` | active |
| QA-5 | Skills are well-formed and registered | `scripts/check-consistency.sh` | its line for QA-5 starts with `OK` | active |
| QA-6 | Links in Markdown files are valid     | `scripts/check-consistency.sh` | its line for QA-6 starts with `OK` | active |

`scripts/check-consistency.sh` runs QA-2 to QA-6 in one call and prints the findings of every
failed check; `scripts/check-consistency.sh help` describes each check. Run it once for all of
its measurements.

## 1. Prepare

1. Read the table above. If `doc/qameasures.md` exists, compare it with the table: every
   decided measure must have a row. Report missing or extra rows as a finding of the skill
   itself; do not add rows on your own.
2. Check that the tools the active measurements need are installed (see
   `doc/developerInfrastructure.md`). A measurement whose tool is missing is reported as
   *not run*, with the tool to install.

## 2. Execute

- Run every `active` measurement from the repository root. Run independent measurements
  together where possible; do not stop at the first failure.
- Measurements must not change the project. Run tools that can modify files (e.g. formatters)
  only in their check mode. If `git status` shows changes after the measurements that were not
  there before, report them.
- Keep the relevant output of every failed measurement (the failing tests, findings or broken
  links), not the full log.

## 3. Report

Report to the user:

- a table with every measurement: ID, measurement, result (*passed*, *failed*, *not run*,
  *planned*) and a short summary (e.g. "68 checks, 0 failed" or "2 broken links"),
- for every failure: the findings with file and line where available,
- findings of the skill itself (step 1), e.g. measures in `doc/qameasures.md` that are missing
  in the table.

For every failure, propose a fix or a new task (skill `add-task`), and wait for the user's
decision. Do not commit changes unless the user asks for it.
