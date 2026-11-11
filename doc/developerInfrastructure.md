# Developer Infrastructure

This document defines the tools that must be installed on every developer's computer.

AI coding agents working in this repository **can rely on these tools being available** and may use them
in scripts and while executing tasks. Agents must not assume any tool that is not listed here. If a new tool
is needed, add it to this document first, so the whole team installs it.

## Required tools

| Tool   | Minimum version | Purpose                                                    | Check installation  |
|--------|-----------------|------------------------------------------------------------|---------------------|
| Bash   | 3.2             | Shell for running the scripts in `scripts/`                | `bash --version`    |
| Python | 3.10            | Scripting language for automation and tooling              | `python3 --version` |

### Bash

- **macOS / Linux:** preinstalled.
- **Windows:** use [Git Bash](https://gitforwindows.org/) or WSL (Windows Subsystem for Linux).

macOS ships with Bash 3.2, so scripts must not use features of newer Bash versions
(e.g. associative arrays or `mapfile`) unless the minimum version above is raised.

### Python

- Install from [python.org](https://www.python.org/downloads/) or with a package manager
  (e.g. `brew install python` on macOS, `apt install python3` on Debian/Ubuntu).
- Call Python as `python3`; on some systems `python` is missing or points to Python 2.
- Scripts that need third-party packages must document them (e.g. in a `requirements.txt`)
  instead of assuming they are installed globally.

## Adding a tool

1. Add a row to the table above with minimum version, purpose and a check command.
2. Add installation notes for the supported operating systems.
3. Tell the team, so everyone installs it.
