# AGENTS.md

Guidance for AI coding assistants (Claude Code, Codex, Copilot, Cursor, etc.) working in this repository.

## About this project

This repository is a **template** for software development projects that rely heavily on an AI coding assistant.
It is meant to be cloned and used as the starting point for a new project. When a project is created from
this template, update this file with project-specific information (purpose, tech stack, and a reference to
`doc/buildAndTest.md` for the build and test commands).

## Repository layout

Put every file into the directory for its kind:

| Directory   | Content                                                                 |
|-------------|-------------------------------------------------------------------------|
| `doc/`      | All documentation; the only exceptions are this file, `CLAUDE.md` and the top-level `README.md` |
| `scripts/`  | All scripts (build, test, setup, deployment, utilities)                 |
| `skills/`   | Skills for the AI assistant (see below)                                 |
| `aitasks/`  | Tasks for the AI assistant, one file per task                           |

## Available tools

Use only the tools listed in [`doc/developerInfrastructure.md`](doc/developerInfrastructure.md);
add a tool there before you use it in scripts or instructions.

Use stable releases of all tools, libraries and frameworks. Using a pre-release version (e.g. an
alpha, beta or release candidate) needs the user's explicit decision, recorded in
`doc/architecture.md`.

## Skills

Skills are in `skills/`, one subdirectory per skill with a `SKILL.md`. Before starting work,
check whether a skill applies and follow it. Assistants without native skill support read the
`SKILL.md` directly.

| Skill                  | Use it to                                                                 |
|------------------------|---------------------------------------------------------------------------|
| `add-task`             | create a new task in `aitasks/`                                           |
| `improve-task`         | review and improve a task before it is implemented                        |
| `implement-task`       | implement a task (contains the rules for Definition of Ready, dependencies and Definition of Done) |
| `review-documentation` | check all documents in `doc/` for consistency and correctness             |
| `review-ai-specs`      | check this file, the skills and the other AI docs for speed, efficiency and correctness |
| `perform-qa-measurements` | execute all QA measurements (tests, static and consistency checks) and report the results |

`.claude/skills` is a symbolic link to `skills/`, so Claude Code registers the skills natively;
do not put skills into `.claude/skills` directly (see `doc/developerInfrastructure.md` for
symbolic links on Windows).

## Conventions

- **Scripts:** make shell scripts executable and give each a short header comment explaining
  what it does and how to call it. The scripts are tested by `scripts/test.sh`: add tests for
  every new script or command, and run `scripts/test.sh` after every change to a script.
- **Tasks:** a task file is the specification of the work. Create, review and implement tasks
  with the skills above. Handle tasks with `scripts/tasks.sh` (`scripts/tasks.sh help` shows
  all commands): always create a task with `scripts/tasks.sh new "Short description"` (the
  template is defined in the script), then fill in the remaining sections. The script reads the `ID`, `Status`, `Dependencies` and
  `Short description` rows of the header table, so keep their format intact (dependencies as a
  comma-separated list of task IDs, or `none`).
- **Task status** is kept in the task file and is one of:
  - `open`: not started yet
  - `in-work`: currently being worked on
  - `waiting`: work has started but is blocked, e.g. on input from the user or an external
    party (note the reason)
  - `done`: completed, all acceptance criteria and the Definition of Done are met
  - `aborted`: will not be done (note the reason)

  Always change the status with `scripts/tasks.sh status ID STATE [COMMENT]` (e.g.
  `scripts/tasks.sh status TASK-0003 waiting "Waiting for the user's ratings"`), never by editing
  the task file: the script records the change with a timestamp in the task's **History** and
  requires a reason for `waiting` and `aborted`.
- **Task numbers never change:** a task keeps its ID for its whole life, because commits,
  external links and other tasks refer to it. Only the setup tasks (TASK-0001 to TASK-0007) are
  numbered in the order they are done. For all later tasks, the order is given by their
  dependencies, not by their numbers: if a new task has to be done before existing ones, add it
  to their dependencies instead of renumbering.
- **Project initialization:** `scripts/init-project.sh NAME` turns a new copy of this template
  into a new project (renames it, resets or keeps the git history). It deletes the git history by
  default, so only run it as part of the corresponding task and after the user has confirmed.
- Keep this file up to date when the structure or conventions of the project change.

## Development process

The development process of this project is described in
[`doc/swDevelopmentProcess.md`](doc/swDevelopmentProcess.md).
