# TASK-0006: Create core application with build system

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | TASK-0006 |
| **Short description** | Create core application with build system |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | none |
| **Dependencies**  | TASK-0005 |

## Motivation

All further features need a working foundation: an application skeleton that follows the
defined architecture and can be built, tested and checked automatically. Creating this core
application now, using all the information gathered to define the architecture, ensures that
every following feature is developed on the same structure, with automatic tests and static
quality checks from the start.

## Task description

Using all the information gathered to define the architecture, create a core application with
a build system that can be used as the foundation for further features:

- `README.md`: domain, problems and features of the application
- `doc/qualityobjectives.md`: quality objectives
- `doc/context.md`: context and constraints (e.g. prescribed languages and frameworks)
- `doc/architecture.md`: the software architecture decided on by the user

The core application must:

1. be built with a build tool,
2. support automatic testing,
3. support a static quality check.

Exceptions are allowed if the defined architecture in `doc/architecture.md` states something
else; in that case, follow the architecture.

Following the project conventions in `AGENTS.md`:

- Tools that are not listed in `doc/developerInfrastructure.md` (e.g. the build tool or the
  runtime) must be added there before they are used.
- The commands to build, test and run the static quality check are documented.

Implementing actual features of the application is out of scope; they are added in later tasks.

## Acceptance criteria

- [ ] The structure of the core application follows `doc/architecture.md`.
- [ ] The application is built with a build tool, and the build succeeds from a clean checkout
      with a single documented command.
- [ ] Automatic tests can be run with a single documented command; at least one test exists
      and passes.
- [ ] A static quality check can be run with a single documented command and passes without
      findings.
- [ ] Any deviation from a build tool, automatic testing or static quality checks is justified
      by `doc/architecture.md`.
- [ ] All tools required for building, testing and the static quality check are listed in
      `doc/developerInfrastructure.md`.
- [ ] The commands for building, testing and the static quality check are documented in `doc/`
      and referenced in `AGENTS.md`.

## History

<!--
  Log of all status changes, oldest first. Add a row for every change of the Status field.
  Timestamp format: ISO 8601 with time zone offset, e.g. 2026-11-11T14:30+0100
  (get it with: date +%Y-%m-%dT%H:%M%z).
  Comment: optional, but required for "waiting" and "aborted" (state the reason).
-->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| 2026-11-11T17:24+0100 | open   | Task created  |
