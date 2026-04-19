# ServiceNow SDK Skills Exporter

The ServiceNow SDK (`@servicenow/sdk`) introduces a development model based on **Fluent APIs** and code-defined metadata. To properly understand and use these APIs, the SDK provides the command:

```bash
npx @servicenow/sdk explain <topic>
```

This command returns official documentation and examples directly generated from the SDK itself.

## The Problem

AI-based code generation tools do not all behave in the same way.

### Tooling-enabled agents

Agents such as Claude Code are designed to:

* Execute system commands
* Query documentation dynamically
* Incorporate tool outputs directly into their reasoning loop

This allows them to use now-sdk explain at runtime and generate accurate, context-aware code.

### Limitations of Copilot

In contrast, GitHub Copilot:

* Does not execute system commands automatically
* Does not support autonomous tool calling
* Relies exclusively on the context available in the workspace

As a result, Copilot cannot independently query now-sdk explain. This leads to issues such as:

* Incorrect usage of Fluent APIs
* Mixing legacy Glide patterns with SDK patterns
* Incomplete or hallucinated implementations

## The Solution

This repository exists to bridge that gap. The included script:

* Executes now-sdk explain for each available topic
* Extracts the generated documentation
* Stores it as local files within the project

This effectively makes the official SDK documentation part of the local workspace context. With these files available:

* Copilot can access real SDK documentation through workspace context
* The likelihood of hallucinated APIs is reduced
* Generated code becomes more consistent and accurate
* Behavior is closer to tool-enabled agents

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
