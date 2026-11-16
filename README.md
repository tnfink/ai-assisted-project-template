# ai-assisted-project-template

**Let the AI write the code, and keep control of your project.**

AI coding assistants (AICA) such as Claude Code, Codex, Copilot or Cursor can implement whole
features on their own. Without structure, though, the same problems keep coming back:

- **The AI forgets.** Each session starts from zero. Decisions, conventions and the reasons
  behind them are lost unless someone explains them again.
- **The AI guesses.** Vague requests get filled with invented requirements, and architecture or
  technology decisions are made silently in the code.
- **"Done" is not done.** Without clear completion criteria, untested code and outdated
  documentation are reported as finished.
- **Nobody knows why.** Weeks later, it is unclear which task led to which change and which
  assumptions applied.

This template gives humans and AI a shared way of working that solves these problems:

- **Plain-text tasks** in `aitasks/` are the specification and the memory of the project:
  motivation, task description, acceptance criteria, dependencies and a status history.
- **Skills** let the AI create, review and implement tasks in a fixed and repeatable way.
- **Definitions of Ready and Done** make sure work only starts on clear tasks and is only
  finished when it is really finished.
- **Documentation for the AI** (`AGENTS.md`, `doc/`) tells every session where everything is
  and which rules apply. **You make the decisions**; the AI proposes, asks and records them.

> **Note:** This README describes the template. In a project created from it, this file is
> replaced by the project's own README in task `TASK-0002`.

## How to start a project

### 1. Create your project from the template

Install the tools listed in [`doc/developerInfrastructure.md`](doc/developerInfrastructure.md)
(Bash, Python 3 and Git) and an AI coding assistant. Then create the project in one of two ways:

- **Recommended: "Use this template" on GitHub.** On the template's GitHub page, click
  *Use this template* → *Create a new repository*. GitHub creates your own repository with a
  fresh history. Clone it into a directory named after your project:

  ```bash
  git clone <your-repository-url> my-project
  cd my-project
  ```

- **Clone the template directly** (e.g. if your project is not hosted on GitHub):

  ```bash
  git clone https://github.com/tnfink/ai-assisted-project-template.git my-project
  cd my-project
  ```

Start your AI coding assistant in the project directory, e.g. `claude`.

### 2. Learn the cycle: improve, then implement

Every task is worked on in the same two steps. In Claude Code, the skills are slash commands;
in other assistants, ask e.g. "improve TASK-0002".

1. **Improve:** `/improve-task TASK-<NNNN>` checks the task against the current state of the
   project. It fixes outdated references and vague wording directly, and proposes changes of
   scope (e.g. an extra question or a split into several tasks), which you accept or reject.
   It changes only tasks, never the project itself.
2. **Implement:** `/implement-task TASK-<NNNN>` checks the Definition of Ready, the
   dependencies and the required tools, sets the task to `in-work` and does the work. It asks
   you whenever information or a decision is needed. At the end, it verifies every acceptance
   criterion and the Definition of Done and sets the task to `done`.
3. **Review** the result, and ask the AI to commit it when you are satisfied.

Running `improve-task` before each task pays off: tasks are written in advance, and the review
adapts them to what earlier tasks have produced.

### 3. Work through the prepared setup tasks

The template contains seven tasks that turn the copy into a real project. Do them in order,
each with the improve-then-implement cycle. They are interactive: the AI asks, you answer and
decide, and the AI writes the results down.

| Task      | What happens                                                                    | Result |
|-----------|---------------------------------------------------------------------------------|--------|
| TASK-0001 | You name the application and choose how to handle git (see below). The AI runs `scripts/init-project.sh`. | Renamed project, `AGENTS.md` |
| TASK-0002 | The AI asks you about the domain, the problems the application solves and its features. | `README.md` of your project |
| TASK-0003 | The AI explains the 9 quality characteristics of ISO 25010 for your application; you rate each from 1 to 5 and say why. | `doc/qualityobjectives.md` |
| TASK-0004 | The AI asks, with examples, about 3rd party systems, prescribed technologies, legal requirements and hosting. | `doc/context.md` |
| TASK-0005 | Topic by topic (structure, language and runtime, frameworks, UI, data storage, integration, deployment, build and test tools), the AI proposes options with pros and cons; you decide. | `doc/architecture.md` |
| TASK-0006 | The AI creates the core application with build, tests and static quality checks, using the decided architecture. | Code, `doc/buildAndTest.md` |
| TASK-0007 | The AI proposes automated QA measures based on your quality objectives; you decide, and the AI creates tasks for them. | `doc/qameasures.md`, new tasks |

**Git in TASK-0001:** with *Use this template*, your repository is kept as it is. With a
direct clone, TASK-0001 either deletes the template's git history and remotes, or keeps the
history and renames the remote `origin` to `upstream`, so you can merge template updates later.
After a direct clone, add your own remote once TASK-0001 is done: `git remote add origin <your-repository-url>`.

> **Caution:** deleting the git history cannot be undone (TASK-0001 asks for confirmation
> first). Run TASK-0001 only in your new project, never in the template itself.

### 4. Continue with your own requirements

After the setup, new work follows the process in
[`doc/swDevelopmentProcess.md`](doc/swDevelopmentProcess.md):

1. **Create tasks** from a requirement: `/add-task <what needs to be done>`.
2. **Improve and implement** each task as described above.
3. **Review the results** and repeat.

Show the current tasks and their dependencies:

```bash
scripts/tasks.sh list          # all tasks
scripts/tasks.sh list open     # only open tasks
scripts/tasks.sh list -deps    # all tasks with their dependencies
scripts/tasks.sh status TASK-0003 waiting "Waiting for the user's ratings"
                               # change the status (recorded in the task's history)
scripts/tasks.sh help          # all commands
```

Each task has a status (`open`, `in-work`, `waiting`, `done`, `aborted`) and a history of all
status changes. Task numbers show the order in which tasks should be done.

## What's inside

| Path                          | Content                                                                 |
|-------------------------------|-------------------------------------------------------------------------|
| `AGENTS.md`                   | Instructions for AI coding assistants: layout, conventions, rules       |
| `CLAUDE.md`                   | Imports `AGENTS.md`, so Claude Code loads the same instructions         |
| `aitasks/`                    | Tasks for the AI, one Markdown file per task                            |
| `doc/`                        | All project documentation                                               |
| `scripts/`                    | All scripts                                                             |
| `skills/`                     | Skills for the AI (`.claude/skills` links here for Claude Code)         |

Key documents and tools:

- [`doc/swDevelopmentProcess.md`](doc/swDevelopmentProcess.md): the AI-based development process,
  including a flowchart
- [`doc/developerInfrastructure.md`](doc/developerInfrastructure.md): the tools every developer
  needs, and which the AI may rely on
- [`doc/aiTaskDefinitionOfReady.md`](doc/aiTaskDefinitionOfReady.md) /
  [`doc/aiTaskDefinitionOfDone.md`](doc/aiTaskDefinitionOfDone.md): criteria a task must meet
  before work starts and before it is done
- `scripts/tasks.sh`: lists and creates tasks and changes their status
- `scripts/init-project.sh`: turns a new copy of the template into a new project
- `scripts/test.sh`: automated tests for the scripts
- Skills `add-task`, `improve-task` and `implement-task`: create, review and implement tasks

## Adapting the template

- **Definition of Ready / Done:** add your project's criteria to
  `doc/aiTaskDefinitionOfReady.md` and `doc/aiTaskDefinitionOfDone.md`.
- **Skills:** add new skills as `skills/<name>/SKILL.md`.
- **Tools:** add new tools to `doc/developerInfrastructure.md` before the AI uses them.
- **Scripts:** add tests for new scripts or commands to `scripts/test.sh` and run it after
  every change.
- **Rules for the AI:** keep `AGENTS.md` up to date when structure or conventions change.

## License

This template is licensed under the [BSD Zero Clause License (0BSD)](LICENSE): you may use, copy,
modify and distribute it for any purpose, without having to keep any copyright notice.

Projects created from the template do not inherit this license: TASK-0001 removes the `LICENSE`
file, so you can choose your project's own license.
