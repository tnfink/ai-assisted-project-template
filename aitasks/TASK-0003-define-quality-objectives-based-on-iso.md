# TASK-0003: Define quality objectives based on ISO 25010

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | TASK-0003 |
| **Short description** | Define quality objectives based on ISO 25010 |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | none |
| **Dependencies**  | TASK-0002 |

## Motivation

To specify and guide the architecture design, quality objectives must be defined. Rating how
important each quality characteristic is for this application makes trade-offs explicit
(e.g. performance versus maintainability) and gives humans and AI agents a documented basis
for architecture decisions.

## Task description

Define the quality objectives of the application using the 9 quality characteristics of the
product quality model of ISO/IEC 25010 (2023 edition):

1. Functional suitability
2. Performance efficiency
3. Compatibility
4. Interaction capability
5. Reliability
6. Security
7. Maintainability
8. Flexibility
9. Safety

For each characteristic:

- Ask the user to give a rating between 1 and 5, where 5 means maximal important.
- Ask the user for some explanation of the rating.

Save the results in `doc/qualityobjectives.md`.

The ratings and explanations come from the user; the AI asks for them and does not invent them.

## Acceptance criteria

- [ ] The AI has asked the user for a rating and an explanation for each of the 9 quality
      characteristics.
- [ ] `doc/qualityobjectives.md` exists.
- [ ] `doc/qualityobjectives.md` lists all 9 quality characteristics of ISO/IEC 25010.
- [ ] Each characteristic has a rating between 1 and 5 (5 = maximal important), as given by
      the user.
- [ ] Each characteristic has an explanation of its rating, based on the user's answer.

## History

<!--
  Log of all status changes, oldest first. Add a row for every change of the Status field.
  Timestamp format: ISO 8601 with time zone offset, e.g. 2026-11-11T14:30+0100
  (get it with: date +%Y-%m-%dT%H:%M%z).
  Comment: optional, but required for "waiting" and "aborted" (state the reason).
-->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| 2026-11-11T16:19+0100 | open   | Task created  |
