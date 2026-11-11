<!--
  Template for a task executed by an AI coding assistant.
  Copy this file to aitasks/<ID>-<short-name>.md (e.g. aitasks/TASK-0001-user-login.md),
  fill in all sections and remove these comments.
-->

# <ID>: <Short description>

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | <!-- Unique identifier, e.g. TASK-0001 -->                    |
| **Short description** | <!-- One line summarizing the task -->                    |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | <!-- Optional, e.g. https://jira.example.com/browse/PROJ-123; otherwise "none" -->  |
| **Dependencies**  | <!-- IDs of tasks that must be done first, e.g. TASK-0002, TASK-0005; otherwise "none" --> |

## Motivation

<!--
  Why is this task important? What problem does it solve, who benefits,
  and what happens if it is not done? Give the AI enough context to make
  sensible decisions in situations the task description does not cover.
-->

## Task description

<!--
  What needs to be done? Describe the expected changes, relevant files,
  components or documents in doc/, constraints, and anything that is
  explicitly out of scope.
-->

## Acceptance criteria

<!--
  Concrete, verifiable conditions that must all be met for the task to be
  considered done. Prefer criteria that can be checked by a command, test,
  or inspection.
-->

- [ ] <!-- e.g. Feature X behaves as described when ... -->
- [ ] <!-- e.g. Automated tests for X exist and pass (scripts/test.sh) -->
- [ ] <!-- e.g. Documentation in doc/ is updated -->

## History

<!--
  Log of all status changes, oldest first. Add a row for every change of the Status field.
  Timestamp format: ISO 8601 with time zone offset, e.g. 2026-11-11T14:30+0100
  (get it with: date +%Y-%m-%dT%H:%M%z).
  Comment: optional, but required for "waiting" and "aborted" (state the reason).
-->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| <!-- YYYY-MM-DDThh:mm±hhmm --> | open   | Task created  |
