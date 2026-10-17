# Claude Code workflow

Opus runs the main session at medium effort, with an Opus advisor. Cheap Haiku subagents handle search and research, and a Sonnet subagent handles scoped implementation.

| Agent | Model / effort | Tools | Use |
|---|---|---|---|
| `Explore` (overrides the built-in, which otherwise runs on the main model) | haiku / low | Read, Grep, Glob, Bash | locate code; one narrow question per agent |
| `Researcher` | haiku / low | Read, Grep, Glob, WebFetch, WebSearch (no CLAUDE.md) | one web/docs question per agent |
| `Worker` | sonnet / medium | all | well-specified implementation subtasks |

Project-specific agents (e.g. the SAMP workspace's `HarnessRunner`, `Tryout`, `Releaser`) live in that project's `.claude/agents/`.

## The Haiku 100k rule
Haiku 5.5 costs 5x more per token once a prompt passes 100k tokens. So:
- every Haiku agent has `autoCompactWindow: 100000` (the minimum allowed), and `settings.json` sets `modelSettings.claude-haiku-5-5.autoCompactWindow = 100000`; every other model compacts at 500k (top-level `autoCompactWindow`);
- one small task per Haiku agent; for more work, spawn several;
- Haiku agents read excerpts, send long output to files, never call the advisor (an Opus advisor would read their whole transcript at Opus rates), and hand judgment back as `DECISION NEEDED: ...`.

## Advisor
`advisorModel: "opus"`. Its effort can't be configured; you only choose the model. **It stays off while `DISABLE_TELEMETRY` (or `DO_NOT_TRACK`, `DISABLE_GROWTHBOOK`, `CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC`) is set**, because those stop the feature-flag fetch that turns it on. `CLAUDE_CODE_EFFORT_LEVEL` would override agent effort, `CLAUDE_CODE_SUBAGENT_MODEL_FORCE` agent models, and `CLAUDE_CODE_AUTO_COMPACT_WINDOW` every compaction window: keep them unset.

`/effort` saves per model into `modelSettings`, so running it changes the Opus default. A top-level `effortLevel` in user settings no longer applies to Opus 5.5.

## Install
- macOS/Linux: `stow -d ~/dev/dotfiles -t "$HOME" claude` links `~/.claude/agents/` and `~/.claude/CLAUDE.md`.
- Windows (no admin needed): junction the agents folder and copy CLAUDE.md:
  ```powershell
  New-Item -ItemType Junction -Path "$env:USERPROFILE\.claude\agents" -Target "D:\dev\dotfiles\claude\.claude\agents"
  Copy-Item D:\dev\dotfiles\claude\.claude\CLAUDE.md "$env:USERPROFILE\.claude\CLAUDE.md"
  ```
- Merge `docs/claude/settings.workflow.json` into `~/.claude/settings.json` by hand. The live file also holds machine-specific hooks, the status line and env, and Claude Code rewrites it.
