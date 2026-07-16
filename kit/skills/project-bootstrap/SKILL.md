---
name: project-bootstrap
description: Establish one canonical current-facts entry for a new or existing project without changing business code. Use when this continuity kit is first introduced, when project state is unclear, or when multiple handoff/status documents conflict.
---

# Project Bootstrap

Create a reliable starting point for future AI work. This skill does **not** implement product features or refactor the repository.

## Trigger

Run when:

- the continuity kit is first copied into a project;
- a new project needs its initial framework and status;
- an existing project has conflicting README, Issue, TODO, handoff or architecture descriptions;
- the user says future AI keeps losing progress or inventing a second architecture.

Do not run repeatedly once `PROJECT.md` is healthy. Later changes use `project-doc-sync`.

## Evidence order

Use, in order:

1. the user's current explicit requirements, constraints and decisions;
2. actual code, configuration, schema and executable interfaces;
3. test, CI, log and target-environment output;
4. existing documentation;
5. Issues, historical discussion and old handoffs.

When sources disagree, do not silently choose. Record the conflict or ask only when it blocks a correct current fact.

## Minimal discovery

Read only enough to establish current facts:

- root file list and primary language/build manifests;
- existing `README.md`, `AGENTS.md`, `PROJECT.md`, architecture/deployment docs;
- current Issue or accepted plan if provided;
- entrypoints, service definitions, key configuration and tests relevant to claimed features;
- recent verification output supplied by the user.

Do not perform a full repository audit. Do not read every source file. Unknowns belong in `PROJECT.md`.

## Installation and merge rules

1. Copy `AGENTS.md`, `PROJECT.md` and `skills/` from the kit only when missing.
2. If an existing file has the same name, do not overwrite it automatically.
3. Merge responsibilities, not paragraphs:
   - one `AGENTS.md` entry;
   - one canonical `PROJECT.md` current-facts file;
   - one Skill per responsibility.
4. Preserve valid project-specific security and operational constraints.
5. Remove or clearly deprecate duplicate files that claim to be the current status, only after their live facts are merged.
6. Do not delete historical changelogs, ADRs or retrospectives merely because they are not current-state documents.

## Build `PROJECT.md`

Fill every section with supported current facts:

- project purpose and users;
- current goal and measurable acceptance criteria;
- required features, later features and explicit non-goals;
- invariants and safety boundaries;
- architecture, responsibilities and data flow;
- exact commands, endpoints, ports, environment keys and paths;
- data ownership, persistence, backup and destructive boundaries;
- setup, startup, core use, backup, restore and failure flows;
- feature/progress table;
- next executable steps;
- documentation ownership map;
- known unknowns.

Use only these status values:

- `计划中`
- `已实现/未验证`
- `已验证`
- `暂停`
- `放弃`

A file, function or test existing is not proof that it ran. Mark `已验证` only with a concrete command result, CI result, log, target-environment smoke or explicit grounded human confirmation.

## Drift cleanup

Search current-state documents for contradictions caused by the bootstrap:

- two different module or service names for one thing;
- old ports, paths, commands or environment keys;
- features described as both implemented and planned;
- an Issue claiming to be the architecture source;
- duplicate `STATUS`, `STATE`, `HANDOFF` or TODO documents with overlapping authority.

Correct or deprecate only the conflicting current-state claims. Do not rewrite project history.

## Stop line

After the current-facts system is established:

- do not implement product code;
- do not redesign architecture;
- do not fix unrelated bugs;
- do not open a broad refactor;
- report unknowns honestly.

## Completion report

Return:

```text
Project bootstrap
- Installed/merged: <files>
- Canonical entry: PROJECT.md
- Current status: <one paragraph>
- Deprecated duplicate entrypoints: <files or none>
- Unknowns: <facts not established>
- Next executable step: <one step>
- Business code changed: no
```
