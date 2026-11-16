---
name: perform-qa-measurements
description: Execute all QA measurements of the project (automated tests, static checks and consistency checks) and report the results. Use when the user asks to run, perform or execute the QA measures, the quality checks or all checks (e.g. before a release or as part of the regular maintenance). Runs the measurements listed in this skill; it does not fix findings.
---

# perform-qa-measurements

Executes every QA measurement of the project and reports the result of each. This is the
activity "Perform QA measures on the code" of the regular maintenance in
`doc/swDevelopmentProcess.md`.

The skill only measures: it does not change code, documents or tasks. Findings are reported and
turned into fixes or tasks with the user's consent.

## Measurements

The table lists all measurements of the project. It starts with the measurements of the
template itself. **TASK-0007** adapts it to the QA measures decided in `doc/qameasures.md`:
every decided measure gets a row, and the template measurements that still apply stay. A
measure whose implementation task is not yet `done` is listed with the status
`planned (TASK-<NNNN>)` and skipped; that task sets it to `active` and fills in its command.

| ID   | Measurement                     | Command (see below)        | Passes when                             | Status |
|------|---------------------------------|----------------------------|-----------------------------------------|--------|
| QA-1 | Tests of the scripts            | `scripts/test.sh`          | exit code 0, "0 failed"                 | active |
| QA-2 | Syntax and permissions of the scripts | *Scripts* below      | no output except "scripts OK"           | active |
| QA-3 | Task files are readable         | `scripts/tasks.sh list -deps` | exit code 0, every task listed       | active |
| QA-4 | Task dependencies are valid     | *Task dependencies* below  | exit code 0                             | active |
| QA-5 | Skills are well-formed and registered | *Skills* below       | no output except "skills OK"            | active |
| QA-6 | Links in Markdown files are valid | *Links* below            | exit code 0                             | active |

### Commands

**Scripts** (QA-2): every script has valid Bash syntax and is executable.

```bash
ok=1; for f in scripts/*.sh; do bash -n "$f" || ok=0; [ -x "$f" ] || { echo "not executable: $f"; ok=0; }; done; [ $ok = 1 ] && echo "scripts OK"
```

**Task dependencies** (QA-4): every dependency exists and has a lower number than the task
(task numbers show the order, see `AGENTS.md`).

```bash
python3 -I - <<'EOF'
import re, pathlib, sys
tasks = {}
for f in sorted(pathlib.Path('aitasks').glob('TASK-*.md')):
    t = f.read_text(encoding='utf-8')
    tid = re.search(r'^\| \*\*ID\*\* +\| (\S+)', t, re.M).group(1)
    deps = re.search(r'^\| \*\*Dependencies\*\* +\| ([^|]*)\|', t, re.M).group(1).strip()
    tasks[tid] = [d.strip() for d in deps.split(',')] if deps != 'none' else []
bad = [f'{t}: unknown dependency {d}' for t, ds in tasks.items() for d in ds if d not in tasks]
bad += [f'{t}: depends on later task {d}' for t, ds in tasks.items() for d in ds if d in tasks and d >= t]
print('\n'.join(bad) or f'{len(tasks)} tasks, dependencies OK'); sys.exit(1 if bad else 0)
EOF
```

**Skills** (QA-5): every skill has a `SKILL.md` whose `name` equals its directory and which has
a `description`, every skill is listed in the skills table of `AGENTS.md`, and `.claude/skills`
links to `skills/`.

```bash
ok=1; for d in skills/*/; do n=$(basename "$d"); { grep -q "^name: $n\$" "$d/SKILL.md" && grep -q '^description: ..' "$d/SKILL.md"; } || { echo "bad frontmatter: $n"; ok=0; }; grep -q "^| \`$n\`" AGENTS.md || { echo "not in AGENTS.md: $n"; ok=0; }; done; [ "$(readlink .claude/skills)" = ../skills ] || { echo "bad link: .claude/skills"; ok=0; }; [ $ok = 1 ] && echo "skills OK"
```

**Links** (QA-6): every relative link in a Markdown file points to an existing file.

```bash
python3 -I - <<'EOF'
import re, pathlib, sys
bad = []
for md in pathlib.Path('.').rglob('*.md'):
    if '.git' in md.parts or '.claude' in md.parts:
        continue
    for target in re.findall(r'\]\(([^)#\s]+)', md.read_text(encoding='utf-8')):
        if '://' not in target and not target.startswith('mailto:') and not (md.parent / target).exists():
            bad.append(f'{md}: {target}')
print('\n'.join(bad) or 'all links OK'); sys.exit(1 if bad else 0)
EOF
```

## 1. Prepare

1. Read the table above. If `doc/qameasures.md` exists, compare it with the table: every
   decided measure must have a row. Report missing or extra rows as a finding of the skill
   itself; do not add rows on your own.
2. Check that the tools the active measurements need are installed (see
   `doc/developerInfrastructure.md`). A measurement whose tool is missing is reported as
   *not run*, with the tool to install.

## 2. Execute

- Run every `active` measurement from the repository root. Run independent measurements
  together where possible; do not stop at the first failure.
- Measurements must not change the project. Run tools that can modify files (e.g. formatters)
  only in their check mode. If `git status` shows changes after the measurements that were not
  there before, report them.
- Keep the relevant output of every failed measurement (the failing tests, findings or broken
  links), not the full log.

## 3. Report

Report to the user:

- a table with every measurement: ID, measurement, result (*passed*, *failed*, *not run*,
  *planned*) and a short summary (e.g. "68 checks, 0 failed" or "2 broken links"),
- for every failure: the findings with file and line where available,
- findings of the skill itself (step 1), e.g. measures in `doc/qameasures.md` that are missing
  in the table.

For every failure, propose a fix or a new task (skill `add-task`), and wait for the user's
decision. Do not commit changes unless the user asks for it.
