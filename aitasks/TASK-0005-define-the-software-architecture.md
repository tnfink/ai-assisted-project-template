# TASK-0005: Define the software architecture

| Field             | Value                                                         |
|-------------------|---------------------------------------------------------------|
| **ID**            | TASK-0005 |
| **Short description** | Define the software architecture |
| **Status**        | open <!-- One of: open, in-work, waiting, done, aborted -->   |
| **External link** | none |
| **Dependencies**  | TASK-0002, TASK-0003, TASK-0004 |

## Motivation

The software architecture is the foundation for all further implementation work. Once the
features of the application (TASK-0002), its quality objectives (TASK-0003) and its context and
constraints (TASK-0004) are known, a fitting architecture can be defined. A documented,
user-approved architecture gives humans and AI agents a common structure to follow and keeps
implementation decisions consistent.

## Task description

After TASK-0002, TASK-0003 and TASK-0004 are done, define a software architecture.

If the application builds on existing code (e.g. a port, a rewrite or an extension of an
existing system, see `README.md` and `doc/context.md`), analyze that code before proposing
anything: its programming language, the libraries and frameworks it uses, and its structure.
Base the proposals on this analysis and summarize it in `doc/architecture.md`.

The architecture covers both the structure and the technology stack, and is decided topic by
topic. It covers at least these topics:

- only if the application builds on existing code: how the existing code is reused (e.g. kept
  and called, partly ported, or replaced), and where the existing code and other 3rd party
  artifacts are located in the repository,
- the structure of the application (e.g. modular monolith or microservices),
- the programming language and its runtime, including their versions (e.g. the JDK, Python or
  Node.js version),
- the server-side framework,
- the UI technology,
- the data storage (e.g. the database and the data access),
- the integration of the 3rd party systems listed in `doc/context.md`,
- the deployment and operation (e.g. packaging, hosting, backup),
- the build tool, the test framework and the tool for the static quality check (needed by
  TASK-0006).

A topic that does not apply to the application (e.g. no UI) is skipped with a short note in
`doc/architecture.md`. If the user wants to decide a topic later, create a task for it with
the skill `add-task` and note the task in `doc/architecture.md`. Decide on stable releases; a
pre-release version needs the user's explicit decision.

For each topic:

1. Introduce a fitting architecture to the user, based on the results of the previous tasks:
   - the domain, problems and features in `README.md`,
   - the quality objectives in `doc/qualityobjectives.md`,
   - the context and constraints in `doc/context.md`.
   Present the proposed architecture together with at least one alternative, and state the
   advantages and disadvantages of each with respect to the quality objectives and the
   constraints.
2. Discuss the architecture with the user.
3. The user decides in the end on the software architecture. The AI proposes and discusses,
   but does not decide. Ask the user for the reason of each decision. If the user gives no
   reason of their own, tell the user that the arguments of the proposal will be recorded as
   the rationale, and mark it in `doc/architecture.md` as "proposed by the AI, accepted by
   the user".
4. Save the results in `doc/architecture.md`, with one section per topic, including:
   - the architecture the user decided on,
   - the alternatives that were discussed,
   - the rationale for the decision, i.e. why the user chose this architecture over the
     alternatives (e.g. with respect to the quality objectives and constraints).

Finally, add a rule to `AGENTS.md` that every implementation must follow
`doc/architecture.md`, so AI agents read it before working on a task.

## Acceptance criteria

- [ ] If the application builds on existing code, the AI has analyzed it (programming language,
      libraries and frameworks, structure), and `doc/architecture.md` summarizes the analysis
      and contains the decisions on the reuse of the existing code and the location of the 3rd
      party artifacts in the repository.
- [ ] For each topic listed in the task description, the AI has introduced a fitting
      architecture and at least one alternative to the user, with their advantages and
      disadvantages with respect to the quality objectives and the constraints, and has
      discussed them with the user.
- [ ] The user has decided on each topic of the software architecture, or a task has been
      created for each topic the user wants to decide later, and `doc/architecture.md` names it.
- [ ] `doc/architecture.md` exists and describes the software architecture the user decided on,
      with one section per topic listed in the task description, including the programming
      language and runtime with their versions, the build tool, the test framework and the
      tool for the static quality check. Topics that do not apply are marked as such.
- [ ] `doc/architecture.md` reflects the results of the discussion with the user.
- [ ] `doc/architecture.md` lists the alternatives that were discussed for each topic.
- [ ] `doc/architecture.md` states the rationale for each decision, as given by the user, or
      marks it as "proposed by the AI, accepted by the user".
- [ ] `AGENTS.md` contains a rule that every implementation must follow `doc/architecture.md`.

## History

<!-- All status changes, oldest first. Maintained by scripts/tasks.sh status; do not edit. -->

| Timestamp                | Status | Comment       |
|--------------------------|--------|---------------|
| 2026-11-11T16:25+0100 | open   | Task created  |
