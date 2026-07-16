---
name: project-doc-sync
description: Synchronize confirmed implementation and design changes into the project's canonical current-facts documents. Use after work changes requirements, features, boundaries, architecture, interfaces, data ownership, operational flows, or progress state.
---

# Project Doc Sync

Keep the next AI from relearning the project or acting on stale facts. Update existing current-state documents from the completed change; do not write a narrative of the conversation.

## Trigger

Run after an implementation or confirmed design decision changes at least one of:

- requirement or acceptance condition;
- implemented feature or user-visible behavior;
- scope boundary, invariant, security rule or explicit non-goal;
- architecture, module responsibility, dependency, topology or data flow;
- exact interface: command, endpoint, port, environment key, script, service, path, token scope or schema;
- data ownership, storage, backup, restore or deletion semantics;
- operational flow: setup, startup, migration, failure handling or rollback;
- progress state or next executable step.

Do not run for formatting, comments, tests-only additions or internal refactors that preserve all documented facts and interfaces.

## Source of truth for the delta

Use only:

1. the originating user request, accepted plan or Issue;
2. the actual changed files or diff;
3. verification output from the completed work;
4. the existing `PROJECT.md` and its documentation ownership map.

Do not rescan the whole repository. Do not treat an unimplemented proposal as current behavior.

## Process

### 1. Extract the fact delta

List concrete `before → after` facts supported by code or verification. Classify each as:

- requirement / acceptance;
- boundary / invariant;
- architecture / responsibility;
- interface / exact identifier;
- data ownership;
- operational flow;
- progress / verification state.

If none changed, stop and report:

```text
No project documentation sync required.
```

### 2. Update `PROJECT.md` first

Correct affected sections in place:

- replace stale facts; do not append a second version;
- copy exact identifiers from code or configuration;
- distinguish `计划中`, `已实现/未验证`, `已验证`, `暂停`, `放弃`;
- update the progress table and current next steps;
- preserve genuine unknowns;
- keep rationale only when it prevents future AI from undoing an important boundary.

### 3. Follow the documentation ownership map

Read `PROJECT.md` section “文档所有权图” and update only affected detailed documents, such as:

- README or user entrypoint;
- architecture and data-flow docs;
- deployment, operations, backup or restore docs;
- API or interface reference;
- current GitHub Issue checklist.

Do not create another status, handoff, architecture summary or TODO list when an existing owner document already exists.

### 4. Check drift caused by this task

Search current-state documents for old identifiers and contradictory statements introduced by the change:

- old commands, ports, environment keys, paths and service names;
- both old and new architecture diagrams;
- features described with conflicting progress states;
- removed behavior still present in setup or acceptance steps;
- planned behavior described as deployed.

Resolve only contradictions caused by this task. Do not use the sync as a broad documentation rewrite.

### 5. Verification discipline

- `已验证` requires concrete evidence: command output, passing tests, CI, target-environment log, smoke or explicit grounded human confirmation.
- Code written but not run remains `已实现/未验证`.
- A failed test is evidence of failure, not evidence that the feature exists.
- Never invent a test result, deployment state, commit or environment behavior.

## Completion report

Return:

```text
Project doc sync
- Updated: <files and changed facts>
- Unchanged: <canonical files checked but unaffected>
- Evidence: <diff/tests/logs/user confirmation>
- Progress changes: <old status → new status>
- Remaining uncertainty: <real unverified facts or none>
```

The report is not a new repository document unless explicitly requested.

## Failure modes to avoid

- copying the conversation or PR summary into `PROJECT.md`;
- adding a changelog entry instead of correcting stale current facts;
- describing plans as implemented;
- renaming interfaces in prose without matching code;
- mechanically updating every document;
- preserving both old and new current-state descriptions;
- creating duplicate `STATUS.md`, `PROJECT_STATE.md`, handoff or TODO files;
- claiming verification from file existence alone.
