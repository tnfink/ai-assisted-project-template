# TASK-0003: Define context and constraints of the application

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | TASK-0003 |
| **Short description** | Define context and constraints of the application |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | none |
| **Dependencies**  | TASK-0001 |

## Motivation

The context and constraints of the application limit the options for the architecture and the
implementation. Knowing early which 3rd party systems must be included, which programming
languages or frameworks are prescribed and which legal or regulatory requirements apply
prevents design decisions that would later have to be reverted, and gives humans and AI agents
a documented basis for all further work.

## Task description

Define the context and constraints of the application by asking the user the following
questions:

- Are there 3rd party systems that must be included?
- Are there constraints on programming languages or frameworks?
- Are there legal or regulatory requirements?

Record the results in `doc/context.md`.

This should be done after TASK-0001, so the domain, problems and features of the application
described in `README.md` are known. The answers come from the user; the AI asks for them and
does not invent them.

## Acceptance criteria

- [ ] The AI has asked the user about 3rd party systems, constraints on programming languages
      or frameworks, and legal or regulatory requirements.
- [ ] `doc/context.md` exists.
- [ ] `doc/context.md` describes the 3rd party systems that must be included, or states that
      there are none.
- [ ] `doc/context.md` describes the constraints on programming languages and frameworks, or
      states that there are none.
- [ ] `doc/context.md` describes the legal and regulatory requirements, or states that there
      are none.
- [ ] The content of `doc/context.md` is based on the user's answers.

## History

<!--
  Log of all status changes, oldest first. Add a row for every change of the Status field.
  Timestamp format: ISO 8601 with time zone offset, e.g. 2026-11-11T14:30+0100
  (get it with: date +%Y-%m-%dT%H:%M%z).
  Comment: optional, but required for "waiting" and "aborted" (state the reason).
-->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| 2026-11-11T16:22+0100 | open   | Task created  |
