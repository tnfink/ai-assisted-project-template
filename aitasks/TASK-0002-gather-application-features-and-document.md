# TASK-0002: Gather application features and document them in README.md

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | TASK-0002 |
| **Short description** | Gather application features and document them in README.md |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | none |
| **Dependencies**  | TASK-0001 |

## Motivation

This is the first step after initializing a project created from this template. As long as the domain of the
application, the problems it solves and the features it provides are unknown, the AI coding
assistant has no basis for planning or implementing anything. Collecting this information from
the user and recording it in a central `README.md` gives humans and AI agents a shared
understanding of the application, and referencing it from `AGENTS.md` ensures every AI agent
reads it before working on further tasks.

## Task description

1. Ask the user about the features of the application. The AI asks for all of the following
   information:
   - the **domain** of the application,
   - the **problems** the application solves,
   - the **new features** the application provides.
2. Save the collected information in a central `README.md` in the repository root. This
   replaces the existing `README.md`, which describes the project template and how to use it;
   its content no longer applies to the new project.
3. Update `AGENTS.md` accordingly.

The information comes from the user; the AI asks for it and does not invent it.

## Acceptance criteria

- [ ] The AI has asked the user about the domain, the problems solved and the new features of
      the application.
- [ ] `README.md` exists in the repository root and describes the domain of the application.
- [ ] `README.md` no longer contains the description of the project template (e.g. the
      sections "Getting started" and "Adapting the template").
- [ ] `README.md` describes the problems the application solves.
- [ ] `README.md` describes the new features the application provides.
- [ ] The content of `README.md` is based on the user's answers.
- [ ] `AGENTS.md` is updated to reflect the information in `README.md`.

## History

<!--
  Log of all status changes, oldest first. Add a row for every change of the Status field.
  Timestamp format: ISO 8601 with time zone offset, e.g. 2026-11-11T14:30+0100
  (get it with: date +%Y-%m-%dT%H:%M%z).
  Comment: optional, but required for "waiting" and "aborted" (state the reason).
-->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| 2026-11-11T16:12+0100 | open   | Task created  |
