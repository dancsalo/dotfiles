# Pi Extension Commands

Human-readable guide to the Pi extensions installed in this dotfiles repo. Use this as a quick command index: search for a command name like `/goal`, `/mcp`, `/workflows`, or `/websearch`.

## Quick index

| Command | Use when you want to... | Extension |
|---|---|---|
| [`/goal`](#goal--autonomous-task-mode) | Keep Pi working until a concrete goal is done or blocked | `@narumitw/pi-goal` |
| [`/rewind`](#rewind--checkpoint-navigation) | Go back to an earlier turn, optionally restoring files | `@ayulab/pi-rewind` |
| [`/checkpoint`](#checkpoint--checkpoint-storage) | Inspect or clean checkpoint storage | `@ayulab/pi-rewind` |
| [`/todos`](#todos--visible-task-list) | Show the current task list | `rpiv-todo` |
| [`/worktree`](#worktree--git-worktree-management) | Create, open, list, remove, or prune git worktrees | `@pandi-coding-agent/pandi-worktree` |
| [`/hypa`](#hypa--output-compression-diagnostics) | Diagnose Hypa shell/tool rewriting | `@hypabolic/pi-hypa` |
| [`/mcp`](#mcp--mcp-server-management) | Configure, inspect, and use MCP servers | `pi-mcp-adapter` |
| [`/mcp setup`](#mcp-setup--guided-mcp-setup) | Import or create MCP config | `pi-mcp-adapter` |
| [`/mcp-auth`](#mcp-auth--mcp-oauth-login) | Authenticate an OAuth MCP server | `pi-mcp-adapter` |
| [`/websearch`](#websearch--interactive-web-research) | Search the web with a review/curation UI | `pi-web-access` |
| [`/curator`](#curator--search-curation-mode) | Toggle/configure web search curation | `pi-web-access` |
| [`/search`](#search--stored-search-results) | Browse previous search results | `pi-web-access` |
| [`/google-account`](#google-account--gemini-web-account) | Check which Google account Gemini Web uses | `pi-web-access` |
| [`/workflows`](#workflows--multi-agent-orchestration) | Run or inspect background multi-agent workflows | `@quintinshaw/pi-dynamic-workflows` |
| [`/workflows-trigger`](#workflows-trigger--keyword-trigger-control) | Control automatic workflow keyword triggering | `@quintinshaw/pi-dynamic-workflows` |
| [`/workflows-progress`](#workflows-progress--live-panel-verbosity) | Change workflow progress panel detail | `@quintinshaw/pi-dynamic-workflows` |
| [`/workflows-models`](#workflows-models--model-tiers) | Map workflow small/medium/big tiers to models | `@quintinshaw/pi-dynamic-workflows` |
| [`/ultracode`](#ultracode-and-effort--standing-workflow-effort) | Auto-arm exhaustive workflows for each task | `@quintinshaw/pi-dynamic-workflows` |
| [`/effort`](#ultracode-and-effort--standing-workflow-effort) | Choose normal/high/ultra workflow effort | `@quintinshaw/pi-dynamic-workflows` |
| [`/deep-research`](#research-and-review-commands) | Produce a sourced web research report | `@quintinshaw/pi-dynamic-workflows` |
| [`/adversarial-review`](#research-and-review-commands) | Have skeptical agents vet a task or answer | `@quintinshaw/pi-dynamic-workflows` |
| [`/multi-perspective`](#research-and-review-commands) | Analyze from several independent angles | `@quintinshaw/pi-dynamic-workflows` |
| [`/code-review`](#research-and-review-commands) | Run parallel code-review agents | `@quintinshaw/pi-dynamic-workflows` |
| [`/codebase-audit`](#research-and-review-commands) | Run multiple checks over a scope | `@quintinshaw/pi-dynamic-workflows` |

## Decision guide

- **Need Pi to keep going until done?** Use `/goal`.
- **Need to undo or retry a previous agent turn?** Use `/rewind`.
- **Need a visible task list?** Ask Pi to use the `todo` tool, then run `/todos` to inspect it.
- **Need a separate branch checkout?** Use `/worktree open` to create/open a git worktree and start a new Pi session there.
- **Need web info?** Use `/websearch` for interactive review, or ask Pi to use `web_search` / `fetch_content`.
- **Need external tools through MCP?** Use `/mcp setup`, then `/mcp`.
- **Need many agents in parallel?** Use `/workflows run ...`, `/deep-research`, `/code-review`, or mention “workflow” in your prompt.
- **Need smaller shell output?** Hypa works mostly automatically; use `/hypa` only for diagnostics.

---

# Command reference

## `/goal` — autonomous task mode

Use `/goal` when a task may take several turns and you want Pi to persist until it either completes, reaches a budget, or reports a true blocker.

```text
/goal fix the failing test and verify the full suite passes
/goal --tokens 100k implement the feature in docs/spec.md
/goal pause
/goal resume
/goal edit ship only the smaller backwards-compatible fix
/goal clear
```

**Good for:** bug fixes, refactors, implementation tasks, test-driven loops.

**Tip:** Keep goals concrete and verifiable. For long instructions, put them in a file and reference it.

## `/rewind` — checkpoint navigation

Use `/rewind` to jump back to an earlier Pi turn. You can restore conversation, files, or both.

```text
/rewind
```

Typical choices:

- **Restore code and conversation**: retry from an earlier point exactly.
- **Restore conversation**: revisit an older branch without touching files.
- **Restore code**: roll files back while keeping the current chat position.

**Good for:** undoing a bad agent turn, retrying a prompt, comparing earlier approaches.

## `/checkpoint` — checkpoint storage

Use `/checkpoint` to inspect checkpoint storage and remove old/orphaned checkpoint data.

```text
/checkpoint
```

**Good for:** cleanup, diagnosing why file restore is or is not available.

## `/todos` — visible task list

`rpiv-todo` gives Pi a `todo` tool for task CRUD and a TUI overlay. `/todos` prints the current list grouped by status.

```text
/todos
```

Ask Pi to manage tasks naturally:

```text
Create todos for implementing auth, mark the first one in progress, and keep the list updated.
```

**Good for:** multi-step tasks where you want visible progress.

## `/worktree` — git worktree management

Use `/worktree` to manage git worktrees without typing raw `git worktree` commands.

```text
/worktree
/worktree list
/worktree add -b feature/login my-feature
/worktree open -b feature/login my-feature
/worktree remove my-feature
/worktree prune --dry-run
/worktree set copy-ignored on
/worktree set copy-untracked off
```

Simple names like `my-feature` are created under `.pi/worktrees/<name>` by default. `/worktree open` does not move the current Pi session; it starts a new Pi session in the worktree, or prints the `cd <path> && pi` command to run manually.

Pi can also use the `git_worktree` tool directly with actions like `list`, `add`, `open`, `remove`, and `prune`.

**Good for:** trying changes on another branch, parallel feature work, or isolating an agent session in a separate checkout.

## `/hypa` — output compression diagnostics

Hypa usually works automatically by rewriting/compressing shell and file-tool output before it fills the context window. Use `/hypa` to inspect status.

```text
/hypa
```

**Good for:** checking whether Hypa is enabled, which binary is used, and the last rewrite result.

## `/mcp` — MCP server management

Use `/mcp` to view MCP servers, connection status, tools, and direct/proxy mode.

```text
/mcp
/mcp tools
/mcp reconnect
/mcp reconnect chrome-devtools
/mcp logout linear
```

**Good for:** databases, browsers, APIs, or other MCP ecosystem tools without loading every tool into context.

Pi can also use the `mcp` proxy tool, for example:

```text
Search MCP tools for screenshot support, then call the best matching tool.
```

## `/mcp setup` — guided MCP setup

Use this when MCP is not configured yet, or when importing configs from Cursor, Claude Code, VS Code, Windsurf, Codex, etc.

```text
/mcp setup
```

**Good for:** first run, adopting existing MCP configs, creating `.mcp.json`.

## `/mcp-auth` — MCP OAuth login

Use this for OAuth-based MCP servers.

```text
/mcp-auth
/mcp-auth linear
```

**Good for:** Linear, GitHub, or other OAuth MCP servers.

## `/websearch` — interactive web research

Open the web search curator directly. You can review results before sending them into the conversation.

```text
/websearch
/websearch react hooks, next.js caching
```

**Good for:** research where source quality matters and you want to select/reject results.

Agent-callable related tools:

```text
web_search({ query: "TypeScript best practices 2025" })
fetch_content({ url: "https://example.com/guide" })
fetch_content({ url: "https://github.com/owner/repo" })
fetch_content({ url: "https://youtube.com/watch?v=abc", prompt: "Summarize the demo" })
```

## `/curator` — search curation mode

Toggle or set how `web_search` returns results.

```text
/curator
/curator on
/curator off
/curator summary-review
```

**Good for:** switching between curated summaries and raw faster results.

## `/search` — stored search results

Browse search/fetch results from the current session.

```text
/search
```

**Good for:** finding a previous response ID or revisiting earlier web sources.

## `/google-account` — Gemini Web account

Show which Google account is active for Gemini Web cookie-based access.

```text
/google-account
```

**Good for:** debugging browser-cookie Gemini access or multiple Chrome profiles.

## `/workflows` — multi-agent orchestration

Use workflows when one agent/context is not enough. Workflows spawn subagents, often in parallel, and return a synthesized result.

```text
/workflows
/workflows run audit every route under src/routes for missing auth checks
/workflows status <run-id>
/workflows save auth-audit
/workflows pause <run-id>
/workflows resume <run-id>
/workflows stop <run-id>
/workflows rm <run-id>
```

**Good for:** codebase audits, broad research, multi-file reviews, cross-checking, parallel experiments.

You can also trigger it naturally:

```text
Run a workflow to find dead code in this repo and verify the findings.
```

## `/workflows-trigger` — keyword trigger control

Control whether typing “workflow” / “workflows” in a prompt auto-arms workflow mode.

```text
/workflows-trigger status
/workflows-trigger off
/workflows-trigger on
/workflows-trigger set pi-workflow
/workflows-trigger reset
```

**Good for:** preventing accidental workflow runs when merely discussing workflows.

## `/workflows-progress` — live panel verbosity

Change how much detail the live workflow panel shows.

```text
/workflows-progress status
/workflows-progress compact
/workflows-progress detailed
/workflows-progress-max 12
```

**Good for:** watching large runs without opening the full `/workflows` navigator.

## `/workflows-models` — model tiers

Configure which models power workflow `small`, `medium`, and `big` agents.

```text
/workflows-models
```

**Good for:** routing cheap scanning to smaller models and synthesis/review to stronger models.

## `/ultracode` and `/effort` — standing workflow effort

Use these to make future substantive prompts automatically use workflow-style effort.

```text
/ultracode
/ultracode off
/effort off
/effort high
/effort ultra
```

**Good for:** difficult coding sessions where you want exhaustive multi-agent help by default.

## Research and review commands

These are workflow-powered shortcuts for common high-leverage tasks.

### `/deep-research`

```text
/deep-research what are the current best practices for passkeys in Rails apps?
```

Use for sourced, cross-checked web research.

### `/adversarial-review`

```text
/adversarial-review evaluate this migration plan for hidden risks
```

Use when you want skeptical reviewers to find flaws.

### `/multi-perspective`

```text
/multi-perspective "Redis vs Postgres for session storage"
/multi-perspective "JWT vs session cookies" security scalability developer-experience
```

Use when a decision benefits from multiple angles.

### `/code-review`

```text
/code-review
/code-review HEAD~3..HEAD
/code-review src/foo.ts
/code-review 42
```

Defaults to reviewing your working diff. A number reviews a GitHub PR diff if `gh` is installed and authenticated.

### `/codebase-audit`

```text
/codebase-audit src/ "missing error handling" "unused exports" "inconsistent naming"
```

Use for parallel checks over a codebase scope.

---

# Useful shortcuts

| Shortcut | What it does |
|---|---|
| `Ctrl+Shift+W` | Toggle web activity monitor (`pi-web-access`) |
| `Ctrl+Shift+S` | Open/search curation shortcut if configured (`pi-web-access`) |

# Installed extensions

These packages are installed under `./.pi/npm`:

- `@ayulab/pi-rewind`
- `@hypabolic/pi-hypa`
- `@narumitw/pi-goal`
- `@pandi-coding-agent/pandi-worktree`
- `@quintinshaw/pi-dynamic-workflows`
- `pi-mcp-adapter`
- `pi-web-access`
- `rpiv-todo`
