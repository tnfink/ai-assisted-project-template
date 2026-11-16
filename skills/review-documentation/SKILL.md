---
name: review-documentation
description: Review all documentation in doc/ for consistency and correctness. Use when the user asks to review, check, verify or clean up the documentation or the docs (e.g. as part of the regular maintenance). Compares the documents with each other and with the actual state of the project, fixes clear errors and asks the user about everything else.
---

# review-documentation

Reviews all documents in `doc/` and checks that they are **consistent** (they do not contradict
each other or the rest of the project) and **correct** (what they state matches the actual
state of the project). This is the activity "Review the technical project documentation" of the
regular maintenance in `doc/swDevelopmentProcess.md`.

The skill changes only documentation. It does not change code, scripts or tasks; problems found
there are reported or turned into tasks.

## 1. Gather the documentation and the project state

1. List all files in `doc/` (e.g. `ls doc/`) and read every one of them completely. For files
   that are not Markdown (e.g. `doc/swdevproc.bpmn`), read the parts that carry content, e.g.
   the labels of a diagram.
2. Read the documents that the documentation in `doc/` refers to or that describe the same
   things: `AGENTS.md`, `README.md`, the skills in `skills/` and the header comments and help
   texts of the scripts in `scripts/`.
3. Get an overview of the project itself: the directory structure, the build files, the
   scripts, and the tasks (`scripts/tasks.sh list -deps`). Read code, configuration and task
   files where a document makes a statement about them.

## 2. Check the consistency

Compare the documents with each other and with `AGENTS.md`, `README.md` and the skills:

- **Contradictions:** do two documents state different things about the same subject (e.g.
  tool versions, commands, decisions, process steps, names of files or statuses)?
- **Duplicates:** is the same information kept in several places? If so, is it identical
  everywhere? Prefer one place and a reference over copies.
- **References:** do all links and mentions of files, directories, sections, scripts, skills
  and task IDs point to something that exists under that name?
- **Completeness of the overviews:** do the lists of documents (e.g. in
  `doc/swDevelopmentProcess.md` and `AGENTS.md`) name every document in `doc/`, and does every
  listed document exist or is it marked as created by a later task?
- **Diagrams:** does every diagram match the text that describes it, and do diagrams that show
  the same thing in different formats (e.g. Mermaid and BPMN) have the same elements and
  labels?
- **Terms and style:** are terms, names and spellings used the same way in all documents
  (e.g. task statuses, skill names, the project name)?

## 3. Check the correctness

Compare every verifiable statement in the documentation with the actual project:

- **Commands:** do the documented commands exist and work as described? Run commands that
  only read or check (e.g. `--help`, `scripts/tasks.sh list`, `scripts/test.sh`, a build or test
  command listed in the documentation). Do not run commands that change or delete data, deploy,
  or need credentials; check those by reading the code instead.
- **Tools and versions:** do the tools and versions in `doc/developerInfrastructure.md` match
  what the scripts and the build actually need (e.g. versions in build files)? Is a tool used
  anywhere that is not listed there?
- **Structure:** do the documented directories, modules, files and endpoints exist, and are
  existing important ones documented?
- **Decisions:** does the code follow the decisions in `doc/architecture.md` (e.g. frameworks
  and libraries in the build files)? A deviation is either an outdated document or a violation
  of the architecture; do not decide which one it is yourself.
- **Status of the work:** do statements about what exists or what is planned match the tasks
  (e.g. a document that describes a feature as done whose task is still `open`)?
- **Up to date:** does a document describe something that has been removed or replaced?

Base every finding on evidence (a file, a command output or a line in a document), not on
assumptions.

## 4. Decide what to change

Sort every finding into one of three groups:

- **Corrections** in `doc/` that restore agreement with the project without changing any
  decision: broken links, outdated file names or commands, wrong version numbers copied from the
  build files, missing entries in overview lists, spelling and formatting. Apply these directly.
- **Questions for the user:** contradictions where it is unclear which side is right, a
  deviation between `doc/architecture.md` and the code, statements about requirements, quality
  objectives or decisions that the user made, and removing or restructuring content.
  **Ask the user first** and apply only what the user decides. Never change a recorded decision
  or its rationale on your own.
- **Outside `doc/`:** problems in `AGENTS.md`, `README.md`, skills, scripts, code or tasks.
  Report them. For `AGENTS.md` and `README.md`, propose the correction and apply it only with
  the user's consent. For work in code, scripts or tasks, propose creating a task with the skill
  `add-task`.

## 5. Apply and verify

1. Apply the corrections and the changes the user agreed to.
2. Check again that all links and references in the changed documents point to existing files
   and sections.
3. If a script's documentation or help text was involved, run `scripts/test.sh`.

## 6. Report

Report to the user:

- which documents were reviewed,
- the corrections you applied, each with the document and the reason,
- the questions you asked and what the user decided,
- the problems outside `doc/` and the proposed tasks,
- the statements you could not verify (e.g. because a command needs credentials), so the user
  can check them.

Do not commit changes unless the user asks for it.
