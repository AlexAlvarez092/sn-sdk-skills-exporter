# ServiceNow SDK Skills Exporter

This repository provides a script that extracts all topics from `npx @servicenow/sdk explain` and writes each topic into its own Markdown file under `.agents/skills`.

The generated files can then be consumed by coding agents (including GitHub Copilot agent workflows) as reusable skill documentation.

## Why This Exists

In the official ServiceNow SDK repository, the `now-sdk-setup` and `now-sdk-explain` skills are designed for agentic coding environments such as Claude Code, Codex, Cursor, and similar tools.

Those environments can generally execute shell commands as part of their autonomous workflow, so they can run the SDK explain command and transform the output into internal documentation.

GitHub Copilot, in many real-world setups, does not reliably perform that same end-to-end autonomous flow by itself (run command, capture output for every topic, and persist all skill files) without explicit user-driven execution and environment support. Common blockers include:

- No guaranteed autonomous shell execution in every Copilot context.
- Security and permission boundaries around local command execution.
- Limited persistence of generated artifacts unless you explicitly save them in the repository.

Because of this, this script makes the process deterministic: you run one command, and the full skill set is generated as versioned Markdown files.

## How to Configure Copilot to Use These Skills

### 1. Keep skills in the expected folder

Use this structure:

```text
.agents/
	skills/
		<skill-name>/
			SKILL.md
```

This script already generates that structure.

### 2. Add repository instructions for Copilot

To help Copilot discover and apply these skills during agent runs, add an `AGENTS.md` file at the repository root (recommended for agent-enabled workflows).

Example:

```markdown
# Agent Instructions

When a task matches an existing skill, read the corresponding file first:

- .agents/skills/<skill-name>/SKILL.md

Prefer skill guidance over generic implementation.
```

### 3. Optionally add `.github/copilot-instructions.md`

If your team uses GitHub Copilot repository instructions, you can also add `.github/copilot-instructions.md` with a short note pointing to `.agents/skills`. This improves consistency across editor and PR experiences.

### 4. Commit generated skills

Do not rely on ephemeral chat context alone. Commit the generated `.agents/skills/**` files so Copilot can use them across sessions and for all collaborators.

## Usage

1. Make sure Node.js and npm are installed.
2. Grant execute permissions to the script:

```sh
chmod +x script.sh
```

3. Run the script to generate all skill documentation files:

```sh
./script.sh
```

## Output

After running the script, each explain topic is exported to:

- `.agents/skills/<topic>/SKILL.md`

You can then reference these files from your Copilot instruction files (`AGENTS.md` and optionally `.github/copilot-instructions.md`).
