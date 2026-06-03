# Start Here

> Documentation maintenance note:
> If this document is updated, also review and update the related documentation listed below when the change affects that area:
>
> - `docs/00_ReadMeFirst/01_documentation_guide.md` — update if documentation rules, folder purposes, maintenance-note rules, or no-orphan-doc rules change.
> - `docs/00_ReadMeFirst/02_project_document_map.md` — update after it is created if project onboarding, document routing, project-state sources, or document relationships change.
> - `docs/00_ReadMeFirst/03_development_workflow.md` — update after it is created if hats, work modes, AI guidance, hat switching, session flow, sprint flow, or workflow routing change.
> - `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md` — update while the Developer Operating System is still being designed.
> - `docs/sprints/current_sprint.md` — update if this start-here routing changes active sprint workflow, documentation TODOs, or Developer Operating System work.
>
> This is the top entry point for the AltarSky Developer Operating System. Keep this document short, clear, and useful as a router. Do not turn it into the full rulebook.

---

# Purpose

This document is the front door to the AltarSky Developer Operating System.

Its job is to help the user, AI, or future maintainer answer:

- Why am I here?
- What am I trying to do?
- Do I understand the project?
- Do I already know what hat or work mode I am wearing?
- Which document should I read next?
- What should I avoid doing right now?

Read this whole document before diving into deeper docs.

If you get lost, come back here.

---

# What This System Is

The AltarSky Developer Operating System is a repo-based workflow system for building AltarSky.

It exists to keep project knowledge outside of memory-only chat and inside version-controlled documentation.

The system helps coordinate:

- Project identity
- Project history
- Current sprint work
- Future plans
- Documentation rules
- Work modes / hats
- Sprint planning
- Sprint closeout
- Idea capture
- Session logs
- AI guidance
- Git hygiene
- System evolution

The repo docs are the source of truth.

The AI should read, follow, and contribute to the repo docs instead of relying only on memory.

---

# Navigation Rule

Do not start by opening random docs.

First answer the routing questions below.

Then follow the matching path.

If you do not understand a word or concept used here, use the fallback paths instead of guessing.

---

# First Routing Questions

Before continuing, answer these:

1. Why are you here?
2. What do you want to know or do?
3. Are you trying to understand the project, manage work, update docs, implement code, test, conceptualize, close a session, close a sprint, or evolve the operating system?
4. Do you already know what hat or work mode you are wearing?
5. Are you switching from another hat or continuing the same work mode?
6. What document is the current source of truth for this task?
7. What should be updated or parked when this task is done?

If you cannot answer these, use the onboarding paths below.

---

# If You Need to Learn What AltarSky Is

Use the Project Onboarding path.

Read:

- `docs/00_ReadMeFirst/02_project_document_map.md` — after it is created, this should explain what AltarSky is, where project identity/history/now/future live, and how the document ecosystem works.
- `docs/planning/roadmap.md` — current and near-term project direction.
- `docs/release_tracker/pre_alpha_0_1.md` — current release target and completion criteria.
- `docs/sprints/current_sprint.md` — what is actively being worked on now.
- `docs/01_devlogs/pre_alpha_0_1/pre_alpha_0_1_history.md` — what has already happened during Pre-Alpha 0.1.
- `docs/01_devlogs/project_milestones.md` — major project timeline.

If you only need the current active work, start with:

- `docs/sprints/current_sprint.md`

---

# If You Need to Understand the Documentation System

Read:

- `docs/00_ReadMeFirst/01_documentation_guide.md`

Use it to understand:

- Where documentation belongs.
- What each folder is for.
- What maintenance notes are.
- How related docs should be updated.
- How to avoid orphan docs.
- Naming rules.
- Template rules.

If you are creating or updating docs, follow the documentation guide before editing.

---

# If You Need to Understand the Document Tree

Read:

- `docs/00_ReadMeFirst/02_project_document_map.md`

This document should explain:

- What document types exist.
- What actual documents exist.
- What each document is for.
- What feeds into what.
- Where project identity, history, now, and future are stored.
- Which docs are source of truth for each kind of work.

If this file does not exist yet, use:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

until the final project document map is created.

---

# If You Need to Understand Hats or Work Modes

Read:

- `docs/00_ReadMeFirst/03_development_workflow.md`

This document should explain:

- What hats are.
- How to choose a hat.
- How to switch hats.
- Startup checklists.
- Handoff checklists.
- What each hat should care about.
- What each hat should ignore.
- How to prevent derailment.
- How to park ideas.
- How session and sprint closeout work.
- How the AI should guide the user.

If this file does not exist yet, use:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

until the final workflow doc is created.

---

# Hat Rule

A hat is the role or work mode being used for the current session.

Examples include:

- Development Systems Architect
- Project Manager
- Scrum Master / Sprint Operator
- Documentation Architect
- Developer
- QA / Tester
- Visionary / Concept Designer
- Art Director / Asset Creator
- Release Manager
- Git / Integration Operator
- Product / Platform Strategist

Do not assume every AltarSky session is a coding session.

If the user says, "I am switching to X hat," follow the hat-switching process in `docs/00_ReadMeFirst/03_development_workflow.md`.

If that workflow doc does not exist yet, use `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md` as the temporary source.

---

# If You Already Know Your Hat

If you already know your hat, do not stay in this document.

Go to:

- `docs/00_ReadMeFirst/03_development_workflow.md`

Then follow that hat's workflow.

If the workflow doc does not exist yet, use:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

After the hat is confirmed, open the related working docs.

Examples:

- Developer Hat: read `docs/sprints/current_sprint.md` and the relevant `docs/systems/` or `docs/game_flow/` doc.
- Project Manager Hat: read roadmap, release tracker, and current sprint.
- Scrum Master Hat: read current sprint, sprint template, blockers, completed work, and closeout rules.
- Documentation Architect Hat: read documentation guide, project document map, and affected docs.
- Development Systems Architect Hat: read all `00_ReadMeFirst/` docs and the Developer Operating System design notes.

---

# If You Are Doing Active Development Work

Read:

- `docs/sprints/current_sprint.md`
- The relevant `docs/systems/` doc
- The relevant `docs/game_flow/` doc, if player flow is affected
- The relevant scripts/scenes/assets

Do not rewrite the Developer Operating System during active development.

If a workflow problem appears, park it as a Developer OS improvement note.

If a major idea appears, park it or switch hats.

---

# If You Are Updating Documentation

Read:

- `docs/00_ReadMeFirst/01_documentation_guide.md`

Then check the maintenance note in the affected document.

Update related docs in the same commit when practical.

If related updates must be deferred, leave a clear TODO in:

- `docs/sprints/current_sprint.md`

or the future Developer OS backlog after it exists.

---

# If You Are Capturing an Idea

First decide whether the idea is current scope.

If it is current sprint scope:

- Add it to `docs/sprints/current_sprint.md` under active tasks or relevant notes.

If it is good but not current scope:

- Park it under the current sprint's deferred ideas / not-current-scope section.
- Later, move it to planning if it survives review.

If it is an operating-system improvement:

- Park it under Developer OS improvement notes.
- Review later while wearing Development Systems Architect Hat.

Do not derail the active hat unless the user explicitly chooses to switch hats.

---

# If You Are Ending a Work Session

At a natural stopping point, choose one:

- Update docs now.
- Add a deferred documentation TODO to `docs/sprints/current_sprint.md`.
- Generate a session log and paste it into the correct place.

If unsure, ask:

- What changed?
- What was completed?
- What decision was made?
- What still needs follow-up?
- What should be parked for later?

---

# If You Are Ending a Sprint

Do not delete completed sprint information.

Follow sprint closeout rules in:

- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/templates/current_sprint_template.md`
- `docs/sprints/current_sprint.md`

If the workflow/template docs do not exist yet, use:

- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`

Sprint closeout should preserve:

- Completed work
- Decisions
- Blockers
- Deferred ideas
- Documentation TODOs
- Release-impacting changes
- System behavior changes
- Game-flow changes
- Planning notes

Then reset `docs/sprints/current_sprint.md` from the sprint template.

Never reset it from memory once the template exists.

---

# If You Are Evolving This Operating System

Wear:

- Development Systems Architect Hat

Read:

- `docs/00_ReadMeFirst/00_start_here.md`
- `docs/00_ReadMeFirst/01_documentation_guide.md`
- `docs/00_ReadMeFirst/02_project_document_map.md`
- `docs/00_ReadMeFirst/03_development_workflow.md`
- `docs/00_ReadMeFirst/99_developer_operating_system_design_notes.md`
- `docs/sprints/current_sprint.md`

Do not silently mutate the operating system from another hat.

Other hats may create improvement notes.

Development Systems Architect reviews and integrates those notes later.

---

# AI First-Response Protocol

When an AI uses this system, it should:

1. Identify why the user is here.
2. Identify or ask for the current hat/work mode.
3. Repeat back the interpreted task briefly.
4. Open or reference the correct source docs.
5. Ask only the required immediate questions.
6. Avoid overloading the user with unnecessary branches.
7. Give one instruction at a time during active implementation unless the user asks for a full plan.
8. If the user asks for copy-paste content, provide one complete uninterrupted copy-paste block.
9. If the user starts work that belongs to another hat, suggest parking it or switching hats.
10. At natural stopping points, remind the user to update docs now or add a deferred TODO.

The AI should not treat memory as the source of truth.

The repo docs are the source of truth.

---

# AI Continuous Improvement Check

When the AI reads or uses the AltarSky Developer Operating System, it should briefly look for one possible improvement, friction point, missing rule, unclear path, repeated manual action, or drift risk.

Before suggesting it, the AI should check existing improvement notes or current sprint deferred notes to avoid duplicates.

If the improvement is new, the AI should give the user a fast way to park it.

Prefer:

- Exact paste block
- Safe terminal append command
- Clear paste destination

Do not derail the current task to solve the improvement immediately.

Park it for later Development Systems Architect review.

---

# Come Back Here If Lost

Come back to this document if:

- You do not know what hat you are wearing.
- You do not know which doc to open.
- You do not know whether something belongs in planning, sprint, systems, game_flow, release tracker, or devlogs.
- You are switching work modes.
- You are ending a session.
- You are ending a sprint.
- The AI or user starts mixing too many abstraction levels.

This document is the front door.

Use it to route.

Do not turn it into the whole building.
