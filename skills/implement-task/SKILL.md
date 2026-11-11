---
name: implement-task
description: Implement an AI task from aitasks/. Use when the user asks to implement, work on, do, execute or start a task (e.g. "implement TASK-0003"). Checks the task against the Definition of Ready before starting and against its acceptance criteria and the Definition of Done before marking it as done.
---

# implement-task

Implements one AI task from `aitasks/`. The task file is the specification. Work only starts
when the task fulfills the Definition of Ready, and the task is only marked as `done` when its
acceptance criteria and the Definition of Done are fulfilled.

## 1. Identify the task

- The user names the task by ID (e.g. `TASK-0003`) or file. Find its file in `aitasks/`.
- If no task is given, run `scripts/tasks.sh list open`, propose the open task with the lowest
  number whose dependencies are all `done`, and ask the user to confirm.
- Read the whole task file.

## 2. Check whether work can start

Do not change anything in the project before all of these checks pass.

1. **Status:** the status must be `open`, `in-work` (resuming) or `waiting` (resuming after the
   reason for waiting is resolved). If it is `done` or `aborted`, stop and tell the user.
2. **Dependencies:** every task listed under **Dependencies** must have the status `done`
   (check with `scripts/tasks.sh list done`). If not, stop and tell the user which dependencies
   are missing.
3. **Definition of Ready:** read `doc/aiTaskDefinitionOfReady.md` and check the task against
   every criterion in it.

If a check fails, do not start the implementation. Report which criteria are not fulfilled and
why. Offer to complete the task description together with the user; change the task file only
with the user's consent, then check again.

## 3. Start the task

1. Set the **Status** in the header table to `in-work`. Keep the row's format intact; only
   replace the value.
2. Add a row to the **History** section with the current timestamp
   (`date +%Y-%m-%dT%H:%M%z`), the status `in-work` and the comment `Implementation started`.

## 4. Implement the task

- Follow `AGENTS.md`, the project documentation in `doc/` and any applicable skills in `skills/`.
  Use only the tools listed in `doc/developerInfrastructure.md`.
- Do what the **Task description** asks for, no more. Do not expand the scope.
- If the task requires decisions or information from the user (e.g. asking for ratings or
  choosing an architecture), ask the user; never invent the user's answers.
- If you discover additional work that is needed but outside this task, do not do it. Propose
  creating a new task with the skill `add-task` instead.
- If you are blocked (e.g. waiting for the user or an external party), set the status to
  `waiting`, add a history row with the reason, and tell the user.

## 5. Check before completion

1. **Acceptance criteria:** check every acceptance criterion of the task. Verify it by a
   command, test or inspection, not by assumption. Tick each verified criterion (`- [x]`).
2. **Definition of Done:** read `doc/aiTaskDefinitionOfDone.md` and check every criterion
   listed there in the same way. If it lists no criteria yet, this check passes.
3. If a criterion is not fulfilled, continue implementing (step 4) and check again. If it
   cannot be fulfilled, leave the status `in-work` or set it to `waiting` with the reason, and
   tell the user.

## 6. Complete the task

Only when all acceptance criteria and all Definition of Done criteria are fulfilled:

1. Set the **Status** to `done`.
2. Add a history row with the current timestamp, the status `done` and the comment
   `All acceptance criteria and the Definition of Done are fulfilled`.
3. Run `scripts/tasks.sh list done` and check that the task appears.
4. Report to the user: what was done, which files were changed, how each acceptance criterion
   was verified, and any open points or proposed follow-up tasks.

Do not commit changes unless the user asks for it.
