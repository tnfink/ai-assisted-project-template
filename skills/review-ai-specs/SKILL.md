---
name: review-ai-specs
description: Review the AI specifications (AGENTS.md, CLAUDE.md, all skills and the other documents that control the AI) for improvements in speed, efficiency and correctness. Use when the user asks to review, check, optimize or improve the AI docs, the AI instructions, the skills or AGENTS.md (e.g. as part of the regular maintenance). Proposes changes and applies them with the user's consent.
---

# review-ai-specs

Reviews the documents that control the AI coding assistant and improves them so that the AI
works **faster** (fewer steps and round trips), more **efficiently** (less context and fewer
tokens for the same result) and more **correctly** (no contradictions, no gaps, no outdated
rules). This is the activity "Optimize the AI docs" of the regular maintenance in
`doc/swDevelopmentProcess.md`.

## 1. Gather the AI specifications

Read these documents completely; together they are the *AI specifications*:

- `AGENTS.md` and `CLAUDE.md` (and any other instruction files for AI assistants, e.g.
  `.github/copilot-instructions.md` or `.cursor/rules/`, if they exist),
- every skill: `skills/*/SKILL.md` and the files a skill refers to,
- the documents the AI must follow by rule: `doc/aiTaskDefinitionOfReady.md`,
  `doc/aiTaskDefinitionOfDone.md`, `doc/developerInfrastructure.md`, `doc/architecture.md`
  (if it exists),
- the task template in `scripts/tasks.sh` (function `print_template`) and the help texts of the
  scripts the AI is told to use,
- shared AI assistant settings checked into the repository (e.g. `.claude/settings.json`).

Also collect **evidence from practice**, where available:

- task histories in `aitasks/`: tasks that went to `waiting` or `aborted`, and why,
- `git log`: commits that corrected the AI's work or changed tasks after a review,
- what the user reports about problems with the AI's behavior.

## 2. Check for correctness

- **Contradictions:** do two specifications give different rules for the same situation
  (e.g. when to commit, how to change a task's status, which tools may be used)?
- **Outdated references:** do all files, directories, scripts, commands, sections, skills and
  task IDs mentioned exist under that name and behave as described? Check scripts with their
  `help` output instead of trusting the documents.
- **Gaps:** are there situations the AI regularly meets without a rule (evidence from step 1),
  or rules that leave the AI guessing (vague words such as "accordingly" or "if needed"
  without a criterion)?
- **Safety:** do steps that are hard to undo (deleting, overwriting, committing, pushing,
  running `scripts/init-project.sh`) require the user's confirmation?
- **Verifiability:** can the AI check each completion condition by a command, a test or an
  inspection?
- **Skill triggers:** does the `description` in each skill's frontmatter say clearly what the
  skill does and when to use it, so the assistant picks the right skill, and do no two skills
  claim the same requests?

## 3. Check for speed and efficiency

- **Duplication:** is the same rule written in several places (e.g. in `AGENTS.md` and in a
  skill)? Every copy costs context in every session and can drift apart. Prefer one place and
  a short reference, unless the rule is essential in both places.
- **Always loaded vs. on demand:** `AGENTS.md` (and `CLAUDE.md`) is loaded in every session;
  skills are only loaded when used. Move detailed procedures that are only needed for one kind
  of work from `AGENTS.md` into a skill or a document in `doc/`, and keep `AGENTS.md` to
  orientation and rules that apply to all work.
- **Length and wording:** remove filler, explanations the AI does not need to act, and
  repetitions. Prefer short imperative rules, lists and tables over prose. Do not shorten
  below clarity: an ambiguous rule causes more round trips than it saves.
- **Round trips with the user:** do skills collect all questions they can ask up front instead
  of one at a time, where the answers do not depend on each other? Do they ask only when the
  answer cannot be derived from the project?
- **Tool calls:** do skills tell the AI to use the scripts (e.g. `scripts/tasks.sh`) instead of
  manual steps, to read only the files that are relevant, and to run independent checks
  together? Are there manual multi-step procedures that a script would do faster and more
  reliably? Propose such a script as a new task (skill `add-task`).
- **Order of checks:** do skills run cheap checks that can stop the work (e.g. status,
  dependencies) before expensive ones (e.g. reading the whole project)?

## 4. Decide what to change

Sort every finding into one of two groups:

- **Corrections** that do not change the AI's behavior: fixing outdated references, typos and
  formatting, aligning a copy of a rule with its source. Apply these directly.
- **Changes of behavior or structure**: adding, removing or changing rules, moving content
  between `AGENTS.md`, skills and `doc/`, changing a skill's steps or description, creating or
  merging skills, and new scripts. **Propose these to the user** with the reason (speed,
  efficiency or correctness) and the evidence, and apply only what the user agrees to.

Never weaken a safety rule (e.g. a required confirmation) for speed without the user's explicit
decision.

## 5. Apply and verify

1. Apply the corrections and the changes the user agreed to. When moving content, leave no
   orphaned references.
2. Check again that all references in the changed documents point to existing files, sections,
   skills and commands, and that the frontmatter of changed skills is intact (`name` equals the
   directory name, `description` present).
3. Keep `doc/swDevelopmentProcess.md`, `README.md` and the skill list in `AGENTS.md` in line
   with the skills that exist.
4. If a script or its help text changed, run `scripts/test.sh`.

## 6. Report

Report to the user:

- which documents were reviewed,
- the corrections you applied,
- the proposed changes, grouped by speed, efficiency and correctness, each with its reason and
  evidence, and what the user decided,
- proposed new tasks (e.g. for scripts),
- the estimated effect, e.g. how much shorter `AGENTS.md` became.

Do not commit changes unless the user asks for it.
