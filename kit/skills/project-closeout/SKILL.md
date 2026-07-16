---
name: project-closeout
description: Close a project or major milestone by freezing final current facts, recording verification and extracting portable lessons for the central continuity kit. Use only when the user says a project or phase is ending, being archived, or ready for handoff.
---

# Project Closeout

Close the work without mixing project-local history into the reusable central kit.

## Trigger

Run when:

- a project is complete or being archived;
- a major phase is accepted and the next phase will be handled separately;
- ownership is changing and a durable final handoff is required;
- the user explicitly asks to extract lessons for future projects.

Do not run after every feature. Normal work uses `project-doc-sync`.

## Evidence

Use:

1. `PROJECT.md` and its progress table;
2. final diff / commits in scope;
3. tests, CI, logs, deployment or manual smoke evidence;
4. unresolved Issues and explicit user decisions.

Do not infer success from plans or file existence.

## Process

### 1. Synchronize current facts first

Run the logic of `project-doc-sync`:

- correct `PROJECT.md`;
- update detailed owner documents;
- mark each feature accurately;
- remove obsolete next steps;
- record real remaining defects or follow-up work.

A project cannot be cleanly closed while its current-state documents are stale.

### 2. Freeze the final project state

Record in `PROJECT.md`:

- final scope delivered;
- acceptance evidence;
- features intentionally omitted or abandoned;
- production/runtime state;
- data and secret locations;
- backup / restore status;
- final known risks;
- exact next action if the project is paused rather than finished.

Do not erase unresolved problems to make the closeout look successful.

### 3. Create a project-local retrospective only when useful

A retrospective is historical, not another current-state source. Create or update one file only when the project has meaningful lessons that need local detail, preferably:

```text
docs/PROJECT_RETROSPECTIVE.md
```

It may contain:

- what worked;
- what failed and why;
- costly dead ends;
- important decisions;
- verification gaps;
- advice for a future maintainer.

It must link back to `PROJECT.md` as the current-facts authority and must not duplicate the full architecture or progress table.

### 4. Extract portable lessons

Separate reusable patterns from project-specific history. For each candidate lesson output:

```markdown
## Candidate lesson — <short name>

**Background**
<generic context, with private/project-specific details removed>

**Pattern**
<the reusable rule>

**Failure mode**
<what goes wrong without it>

**Recommended practice**
<minimum useful action>

**Scope**
<where it applies and where it does not>

**Evidence level**
<source review / implemented-unverified / verified in target environment / repeated across projects>
```

Remove:

- repository and person names unless essential and public;
- usernames, email addresses and absolute home paths;
- tokens, secrets, IDs and private URLs;
- unique business data;
- one-off emotional commentary that does not describe an engineering pattern.

Keep project-local details in the retrospective, not in the portable lesson.

### 5. Central-kit update boundary

Do not directly edit an external continuity-kit repository unless the user explicitly authorizes it and the tool has access.

Otherwise return the candidate lessons so they can be reviewed and merged into the central `LESSONS.md` later.

A lesson should enter the central kit only when:

- it is supported by code, source review or real runtime evidence;
- it is useful beyond this one repository;
- its scope and uncertainty are stated;
- it does not duplicate an existing lesson.

### 6. Final repository checks

Confirm:

- secrets and runtime data are not tracked;
- destructive commands and recovery boundaries remain documented;
- open Issues match remaining work;
- the final state is committed or the uncommitted state is explicitly reported;
- no duplicate file claims to be the current project state.

## Completion report

Return:

```text
Project closeout
- Final state: <completed / phase completed / paused / archived>
- Acceptance evidence: <tests/logs/smoke>
- PROJECT.md synchronized: yes/no
- Project-local retrospective: <path or not needed>
- Remaining work: <items or none>
- Portable lesson candidates: <count>
- Central kit updated: <yes/no/not authorized>
- Uncommitted or unverified facts: <items or none>
```
