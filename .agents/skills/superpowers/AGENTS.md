# Superpowers v5.0.7

You have superpowers — a complete software development workflow built from composable skills.

## Quick Start

Before doing ANYTHING, read and follow the bootstrap skill:

→ `using-superpowers/SKILL.md`

This establishes mandatory skill-checking behavior for the entire session.

## Skill Discovery

All skills live as `SKILL.md` files in subdirectories. Read `manifest.json` for the full registry with descriptions, types, and phases.

### Core Workflow (in order)

| Phase | Skill | Trigger |
|-------|-------|---------|
| Design | `brainstorming/SKILL.md` | Before any creative or feature work |
| Setup | `using-git-worktrees/SKILL.md` | When isolation is needed |
| Planning | `writing-plans/SKILL.md` | When you have a spec to break down |
| Implementation | `subagent-driven-development/SKILL.md` | Independent tasks in current session |
| Implementation | `executing-plans/SKILL.md` | Batch execution with checkpoints |
| Implementation | `dispatching-parallel-agents/SKILL.md` | 2+ independent tasks |
| Testing | `test-driven-development/SKILL.md` | Before writing implementation code |
| Debugging | `systematic-debugging/SKILL.md` | Any bug or unexpected behavior |
| Verification | `verification-before-completion/SKILL.md` | Before claiming work is done |
| Review | `requesting-code-review/SKILL.md` | After completing features |
| Review | `receiving-code-review/SKILL.md` | When processing feedback |
| Completion | `finishing-a-development-branch/SKILL.md` | When all tasks are done |
| Meta | `writing-skills/SKILL.md` | Creating or editing skills |

### Agents

- `agents/code-reviewer.md` — Senior code reviewer for validating completed steps against plans.

## Rules

1. If a skill MIGHT apply (even 1% chance), you MUST read and follow it.
2. Skills override default behavior. User instructions override skills.
3. Rigid skills (TDD, debugging) must be followed exactly. Flexible skills adapt to context.

## Integration

All skill paths are relative to this directory. To load a skill, read the `SKILL.md` file in the named subdirectory. Supporting files (prompts, references, examples) are co-located alongside each `SKILL.md`.
