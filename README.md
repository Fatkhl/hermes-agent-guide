# 🧠 Hermes Agent — Complete Setup Guide

> Step-by-step: Install, Configure, & Make Your AI Agent Smart and Obedient

[![Hermes Agent](https://img.shields.io/badge/Hermes-Agent-6366f1?style=for-the-badge&logo=github)](https://github.com/NousResearch/hermes-agent)
[![Docs](https://img.shields.io/badge/Docs-Official-22c55e?style=for-the-badge)](https://hermes-agent.nousresearch.com/docs/)

---

## 📑 Table of Contents

1. [What is Hermes Agent?](#-what-is-hermes-agent)
2. [System Requirements](#-system-requirements)
3. [Installation](#-installation)
4. [Initial Setup](#-initial-setup)
5. [Model & Provider Configuration](#-model--provider-configuration)
6. [Making the Agent Smart & Obedient](#-making-the-agent-smart--obedient)
7. [SOUL — Agent Personality System](#-soul--agent-personality-system)
8. [Skills System](#-skills-system)
9. [Memory System](#-memory-system)
10. [Toolsets Configuration](#-toolsets-configuration)
11. [Messaging Gateway (Telegram, Discord, etc.)](#-messaging-gateway)
12. [Cron Jobs & Automation](#-cron-jobs--automation)
13. [Multi-Agent Delegation](#-multi-agent-delegation)
14. [Security & Privacy](#-security--privacy)
15. [Troubleshooting](#-troubleshooting)
16. [Complete Workflow Diagram](#-complete-workflow-diagram)

---

## 🤖 What is Hermes Agent?

Hermes Agent is an open-source AI agent framework by **Nous Research** that runs in your terminal, messaging platforms, and IDEs. Unlike regular chatbots, Hermes can:

- **Execute code** and run shell commands
- **Browse the web** and interact with websites
- **Read/write files** on your system
- **Remember** context across sessions
- **Learn** from experience via Skills system
- **Connect** to Telegram, Discord, Slack, WhatsApp, and 10+ platforms
- **Delegate** tasks to sub-agents
- **Schedule** tasks with cron jobs

---

## 📋 System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| OS | Linux, macOS, WSL | Ubuntu 22.04+ / Debian 12+ |
| Python | 3.10+ | 3.11+ |
| RAM | 1 GB | 2+ GB |
| Disk | 1 GB free | 5+ GB free |
| Internet | Required | Stable connection |

---

## ⚡ Installation

### One-Line Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

### Manual Install

```bash
# Clone the repo
git clone https://github.com/NousResearch/hermes-agent.git ~/.hermes/hermes-agent

# Install dependencies
cd ~/.hermes/hermes-agent
pip install -e .

# Verify installation
hermes --version
```

### Update

```bash
hermes update
```

---

## 🔧 Initial Setup

### Step 1: Run the Setup Wizard

```bash
hermes setup
```

This will guide you through:
- Model & provider selection
- API key configuration
- Terminal settings
- Tool enablement

### Step 2: Set Your Model/Provider

```bash
hermes model
```

Interactive picker for:
- **OpenRouter** — access to 200+ models with one API key
- **Anthropic** — Claude models directly
- **Google Gemini** — free tier available
- **DeepSeek** — cheap and powerful
- **Custom endpoint** — any OpenAI-compatible API

### Step 3: Configure API Keys

```bash
# Edit the .env file
nano ~/.hermes/.env
```

Add your API keys:

```env
# Option A: OpenRouter (recommended — one key for all models)
OPENROUTER_API_KEY=sk-or-v1-xxxxx

# Option B: Direct provider
ANTHROPIC_API_KEY=sk-ant-xxxxx

# Option C: Free tier
GOOGLE_API_KEY=AIzaSy-xxxxx

# For custom provider
# (set in config.yaml instead)
```

### Step 4: Health Check

```bash
hermes doctor
```

This checks all dependencies, config validity, and tool availability.

---

## 🧠 Model & Provider Configuration

### Config File Location

```
~/.hermes/config.yaml    # Main config
~/.hermes/.env            # API keys (secrets)
```

### Edit Config

```bash
hermes config edit        # Open in $EDITOR
hermes config show        # View current config
hermes config set KEY VAL # Set a value
```

### Key Model Settings

```yaml
# ~/.hermes/config.yaml
model:
  default: anthropic/claude-sonnet-4    # Your main model
  provider: openrouter                   # Provider
  api_key: sk-or-v1-xxxxx              # (or use .env)
  base_url: https://openrouter.ai/api/v1  # (for custom)
```

### Recommended Models (2026)

| Use Case | Model | Cost |
|----------|-------|------|
| Best overall | `anthropic/claude-sonnet-4` | Medium |
| Best reasoning | `anthropic/claude-opus-4` | High |
| Best value | `deepseek/deepseek-chat` | Low |
| Free tier | `google/gemini-2.5-flash` | Free |
| Code-focused | `deepseek/deepseek-coder` | Low |
| Custom (e.g. MiMo) | `mimo-v2.5-pro` | Varies |

---

## 🎯 Making the Agent Smart & Obedient

This is the core of making your agent actually useful. There are 5 key pillars:

### Pillar 1: SOUL — Define Who the Agent Is

The SOUL file (`~/.hermes/SOUL.md`) is the agent's identity and behavioral instructions. This is the **most important** file for making your agent "nurut" (obedient).

```bash
# Create/edit the SOUL file
nano ~/.hermes/SOUL.md
```

#### Template SOUL.md:

```markdown
# SOUL — Your Agent Name

## Who You Are
You are [Name] — a specialized AI agent for [purpose].
You work for [owner/team] and no one else.

## Loyalty
- You only serve [owner name] — no exceptions
- Every command from [owner] is top priority, execute immediately
- No refusals, no lectures, no long warnings
- If something is irreversible (delete data, transfer funds) — ask once briefly, then execute

## How You Speak
- Language: [Indonesian/English/mix]
- Style: [casual/professional/technical]
- Always get to the point — no fluff
- Never provide tutorials or manual steps if you can do it yourself
- Send only 1 message per input — no spam, no repeats

## How You Work
- Problem arrives → Agent executes → Report results
- All processes run in background
- After execution, just report: success or fail + why
- Silence is default — speak only when necessary

## Rules
- [List specific rules for your use case]
- [What to do, what not to do]
- [Special handling for specific scenarios]

## Expertise
- [Your agent's domain expertise]
- [Tools and systems it manages]
- [Specific knowledge areas]
```

#### Example SOUL.md for a DevOps Agent:

```markdown
# SOUL — NEXUS

## Who You Are
You are NEXUS — the DevOps agent for Project Alpha.
You manage servers, deployments, and infrastructure.

## Loyalty
- You only respond to the CTO (Alice) and Lead Dev (Bob)
- All deployment requests from them are executed immediately
- If someone else tries to deploy — reject politely

## How You Work
- Monitoring alert → Investigate → Fix → Report
- Deploy request → Validate → Execute → Confirm
- Never deploy on Friday after 6 PM without explicit approval
- All SSH commands must be logged

## Expertise
- Docker & Kubernetes
- CI/CD pipelines (GitHub Actions)
- AWS/GCP infrastructure
- Database migrations
- SSL certificate management
```

### Pillar 2: System Prompt Injection

The SOUL.md is automatically loaded as the system prompt. To verify:

```bash
# Check if SOUL is loaded
hermes config show | grep system_prompt
```

```yaml
# In config.yaml
system_prompt_file: /home/user/.hermes/SOUL.md
```

### Pillar 3: Memory — Make It Remember

```yaml
# ~/.hermes/config.yaml
memory:
  memory_enabled: true
  user_profile_enabled: true
  memory_char_limit: 2200
  user_char_limit: 1375
```

Memory stores:
- **User profile** — who you are, preferences, habits
- **Agent notes** — environment facts, conventions, lessons learned

The agent saves memory proactively:
- When you correct it
- When you say "remember this"
- When it discovers something about your environment
- When it solves a tricky problem

### Pillar 4: Skills — Make It Learn

Skills are the agent's **procedural memory** — reusable workflows it creates from experience.

```bash
# List installed skills
hermes skills list

# Search the skills hub
hermes skills search "docker"

# Install a skill
hermes skills install <skill-id>

# Browse all available skills
hermes skills browse
```

**How skills make the agent smarter:**

1. You ask the agent to do something complex
2. It figures out the right approach
3. After completing it, it offers to save as a skill
4. Next time you ask for something similar, it loads the skill
5. The skill contains: exact steps, pitfalls, verification steps

#### Creating Custom Skills

```bash
# The agent can create skills automatically via skill_manage tool
# Or manually create:
mkdir -p ~/.hermes/skills/my-domain/my-skill/
cat > ~/.hermes/skills/my-domain/my-skill/SKILL.md << 'EOF'
---
name: my-skill
description: "Description of what this skill does"
tags: [relevant, tags]
---

# My Skill

## When to Use
- When the user asks for X
- When condition Y is met

## Steps
1. Do this first
2. Then do that
3. Verify with this command

## Pitfalls
- Don't do X because Y
- Watch out for Z

## Verification
- Check output contains "success"
- Verify file exists at /path
EOF
```

### Pillar 5: Approval & Safety Settings

```yaml
# ~/.hermes/config.yaml
approvals:
  mode: smart    # Options: manual, smart, off
  timeout: 60
```

| Mode | Behavior |
|------|----------|
| `manual` | Ask before every destructive command |
| `smart` | AI decides — auto-approve low-risk, ask on high-risk |
| `off` | Never ask (use `--yolo` flag for one-time bypass) |

For maximum obedience with safety:
```bash
hermes config set approvals.mode smart
```

---

## 🎭 SOUL — Agent Personality System

### Display Settings

```yaml
# ~/.hermes/config.yaml
display:
  personality: kawaii     # Personality style
  skin: default           # CLI theme
  show_reasoning: false   # Show thinking process
  compact: false          # Compact output
```

### Available Personalities

Set via `/personality` in chat or config:
- `default` — Professional and helpful
- `kawaii` — Cute and expressive
- `pirate` — Arrr, matey!
- `custom` — Define your own in config

### Custom Personality

```yaml
# In config.yaml
personalities:
  my-style:
    tone: casual
    emoji: true
    verbosity: concise
```

---

## 📚 Skills System

### Skills Architecture

```
~/.hermes/skills/
├── category-1/
│   ├── skill-a/
│   │   ├── SKILL.md          # Main skill doc
│   │   ├── references/       # API docs, specs
│   │   ├── templates/        # Code templates
│   │   ├── scripts/          # Helper scripts
│   │   └── assets/           # Images, configs
│   └── skill-b/
│       └── SKILL.md
└── category-2/
    └── skill-c/
        └── SKILL.md
```

### Essential Skills to Install

```bash
# Web development
hermes skills search "web development"
hermes skills install popular-web-designs

# DevOps
hermes skills search "docker"
hermes skills install docker-compose

# GitHub workflow
hermes skills search "github"
hermes skills install github-pr-workflow

# Research
hermes skills search "research"
hermes skills install arxiv
```

### Skill Management Commands

```bash
hermes skills list              # List installed
hermes skills search QUERY      # Search hub
hermes skills install ID        # Install
hermes skills update            # Update all
hermes skills check             # Check for updates
hermes skills uninstall NAME    # Remove
hermes skills publish PATH      # Publish to registry
hermes skills tap add REPO      # Add GitHub repo as source
```

### In-Session Skill Commands

```
/skills                         # Search/install (CLI)
/skill <name>                   # Load skill into session
```

---

## 🧠 Memory System

### How Memory Works

```
┌─────────────────────────────────────────┐
│           Session Context               │
│  ┌─────────────────────────────────┐    │
│  │ System Prompt (SOUL.md)         │    │
│  │ + Injected Memory               │    │
│  │ + Loaded Skills                 │    │
│  └─────────────────────────────────┘    │
│                                         │
│  Conversation happens here...           │
│                                         │
│  Agent saves facts to memory ──────────────→ ~/.hermes/memory/
│  Agent creates skills ─────────────────────→ ~/.hermes/skills/
└─────────────────────────────────────────┘
```

### Memory Best Practices

**What to save (agent does this automatically):**
- User preferences (language, style, shortcuts)
- Environment details (OS, installed tools, paths)
- Project conventions (naming, structure, testing)
- Tool quirks and workarounds
- Recurring corrections

**What NOT to save:**
- Task progress (use session search instead)
- Temporary state
- Raw data dumps
- Things easily re-discovered

### Manual Memory Management

```bash
hermes memory status    # Check memory state
hermes memory setup     # Configure provider
hermes memory off       # Disable
```

### In-Session Memory

The agent uses the `memory` tool:
- `memory(action='add')` — Save new fact
- `memory(action='replace')` — Update existing fact
- `memory(action='remove')` — Delete fact

---

## 🔧 Toolsets Configuration

### Available Toolsets

| Toolset | What It Does | Default |
|---------|-------------|---------|
| `terminal` | Shell commands, processes | ✅ |
| `file` | Read/write/search files | ✅ |
| `browser` | Web automation | ✅ |
| `web` | Web search & extraction | ✅ |
| `code_execution` | Sandboxed Python | ✅ |
| `vision` | Image analysis | ✅ |
| `memory` | Persistent memory | ✅ |
| `skills` | Skill management | ✅ |
| `delegation` | Sub-agent spawning | ✅ |
| `cronjob` | Scheduled tasks | ✅ |
| `messaging` | Cross-platform messages | ✅ |
| `image_gen` | AI image generation | ❌ |
| `tts` | Text-to-speech | ❌ |
| `homeassistant` | Smart home | ❌ |
| `rl` | Reinforcement learning | ❌ |

### Enable/Disable Tools

```bash
# Interactive UI
hermes tools

# Command line
hermes tools enable image_gen
hermes tools disable homeassistant

# List all
hermes tools list
```

### Per-Platform Toolsets

```yaml
# config.yaml
platform_toolsets:
  cli:
    - hermes-cli
  telegram:
    - hermes-telegram
  discord:
    - hermes-discord
```

---

## 📱 Messaging Gateway

### Supported Platforms

| Platform | Setup Command |
|----------|--------------|
| Telegram | `hermes gateway setup` → select Telegram |
| Discord | `hermes gateway setup` → select Discord |
| Slack | `hermes gateway setup` → select Slack |
| WhatsApp | `hermes whatsapp` |
| Signal | `hermes gateway setup` → select Signal |
| Email | `hermes gateway setup` → select Email |
| Matrix | `hermes gateway setup` → select Matrix |

### Gateway Management

```bash
# Setup
hermes gateway setup          # Interactive platform setup

# Service management
hermes gateway install        # Install as systemd service
hermes gateway start          # Start service
hermes gateway stop           # Stop service
hermes gateway restart        # Restart service
hermes gateway status         # Check status
hermes gateway run            # Run in foreground (debug)
```

### Telegram Setup Example

```bash
# 1. Create bot via @BotFather on Telegram
# 2. Get the bot token
# 3. Add to .env
echo "TELEGRAM_BOT_TOKEN=7012345678:AAHxxxxxxxxxxxxxxx" >> ~/.hermes/.env

# 4. Setup gateway
hermes gateway setup
# Select Telegram, enter token

# 5. Start
hermes gateway start

# 6. Chat with your bot on Telegram!
```

### Gateway In-Session Commands

```
/approve          # Approve pending command
/deny             # Deny pending command
/restart          # Restart gateway
/sethome          # Set current chat as home channel
/status           # Session info
/platforms        # Show platform status
```

---

## ⏰ Cron Jobs & Automation

### Create Scheduled Tasks

```bash
# Via CLI
hermes cron create "0 9 * * *" --prompt "Check server status and send report"

# Via in-session (agent can do this)
# Agent uses the cronjob tool directly
```

### Cron Expressions

| Expression | Meaning |
|-----------|---------|
| `30m` | Every 30 minutes |
| `every 2h` | Every 2 hours |
| `0 9 * * *` | Every day at 9 AM |
| `0 */6 * * *` | Every 6 hours |
| `0 9 * * 1-5` | Weekdays at 9 AM |

### Manage Cron Jobs

```bash
hermes cron list          # List jobs
hermes cron pause ID      # Pause job
hermes cron resume ID     # Resume job
hermes cron run ID        # Trigger now
hermes cron remove ID     # Delete job
hermes cron status        # Scheduler status
```

### Example: Daily Report Cron

```python
# Agent creates this automatically when you ask:
cronjob(
    action='create',
    name='daily-server-report',
    schedule='0 9 * * *',
    prompt='Check server health, disk usage, and running services. Send a summary report.',
    deliver='telegram'  # or 'origin', 'local', 'platform:chat_id'
)
```

---

## 🤝 Multi-Agent Delegation

### delegate_task — Quick Subtasks

```python
# Single task
delegate_task(
    goal="Research the latest crypto airdrops",
    toolsets=["web", "search"]
)

# Parallel tasks
delegate_task(
    tasks=[
        {"goal": "Check server A status", "toolsets": ["terminal"]},
        {"goal": "Check server B status", "toolsets": ["terminal"]},
        {"goal": "Research competitor pricing", "toolsets": ["web"]}
    ]
)
```

### Spawning Independent Agents

```bash
# One-shot mode
hermes chat -q "Research GRPO papers and write summary"

# Background
hermes chat -q "Set up CI/CD for myapp" &

# Interactive (via tmux)
tmux new-session -d -s agent1 'hermes'
tmux send-keys -t agent1 'Build a REST API' Enter
```

### Orchestrator Pattern

```
┌──────────────────┐
│   Main Agent     │
│   (Orchestrator) │
└────────┬─────────┘
         │
    ┌────┴────┐
    │         │
    ▼         ▼
┌────────┐ ┌────────┐
│Worker A│ │Worker B│
│(Frontend)│ │(Backend)│
└────────┘ └────────┘
```

---

## 🔒 Security & Privacy

### Secret Redaction

```bash
# Auto-mask API keys in output
hermes config set security.redact_secrets true
```

### Command Approval

```bash
# Smart mode — AI decides risk level
hermes config set approvals.mode smart

# Manual — always ask
hermes config set approvals.mode manual

# Off — never ask (dangerous!)
hermes config set approvals.mode off
```

### PII Protection

```bash
# Hash user IDs in gateway messages
hermes config set privacy.redact_pii true
```

### Website Blocklist

```yaml
# config.yaml
security:
  website_blocklist:
    enabled: true
    domains:
      - malicious-site.com
      - phishing-example.net
```

---

## 🔥 Troubleshooting

### Common Issues

| Problem | Solution |
|---------|----------|
| Voice not working | `pip install faster-whisper` or set `GROQ_API_KEY` |
| Tool not available | `hermes tools` → check if enabled, then `/reset` |
| Model errors | `hermes doctor` → check config |
| Vision fails | Set `auxiliary.vision.model` to multimodal model |
| Gateway dies on SSH | `sudo loginctl enable-linger $USER` |
| Changes not taking effect | Gateway: `/restart`, CLI: exit and relaunch |
| Skills not showing | `hermes skills list` → verify installed |

### Vision Fix for Custom Providers

```bash
# 1. Check available models
curl -s https://YOUR_PROVIDER/v1/models \
  -H "Authorization: Bearer YOUR_KEY" | python3 -m json.tool

# 2. Set vision model (use omni/vl variant)
hermes config set auxiliary.vision.model mimo-v2-omni
hermes config set auxiliary.vision.base_url https://YOUR_PROVIDER/v1
hermes config set auxiliary.vision.api_key YOUR_KEY

# 3. Restart gateway
systemctl --user restart hermes-gateway.service
```

### Diagnostic Commands

```bash
hermes doctor              # Full health check
hermes status --all        # Component status
hermes config check        # Config validation
hermes insights            # Usage analytics
```

---

## 🔄 Complete Workflow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    HERMES AGENT WORKFLOW                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │  INSTALL  │───▶│  CONFIG  │───▶│  SOUL    │              │
│  │  (Step 1) │    │  (Step 2)│    │  (Step 3)│              │
│  └──────────┘    └──────────┘    └──────────┘              │
│       │               │               │                     │
│       ▼               ▼               ▼                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │  curl     │    │  Model   │    │ Identity │              │
│  │  install  │    │ Provider │    │ Behavior │              │
│  │  script   │    │ API Keys │    │ Rules    │              │
│  └──────────┘    └──────────┘    └──────────┘              │
│                                                             │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │  SKILLS  │───▶│  MEMORY  │───▶│  TOOLS   │              │
│  │  (Step 4) │    │  (Step 5)│    │  (Step 6)│              │
│  └──────────┘    └──────────┘    └──────────┘              │
│       │               │               │                     │
│       ▼               ▼               ▼                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │ Install  │    │ Auto-    │    │ Enable/  │              │
│  │ relevant │    │ saves    │    │ disable  │              │
│  │ skills   │    │ facts &  │    │ per need │              │
│  │ from hub │    │ prefs    │    │          │              │
│  └──────────┘    └──────────┘    └──────────┘              │
│                                                             │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │ GATEWAY  │───▶│  CRON    │───▶│  AGENT   │              │
│  │  (Step 7) │    │  (Step 8)│    │  READY!  │              │
│  └──────────┘    └──────────┘    └──────────┘              │
│       │               │               │                     │
│       ▼               ▼               ▼                     │
│  ┌──────────┐    ┌──────────┐    ┌──────────┐              │
│  │ Telegram │    │ Schedule │    │  Smart   │              │
│  │ Discord  │    │ auto-    │    │  Obedient│              │
│  │ WhatsApp │    │ mated    │    │  Agent   │              │
│  │ Slack    │    │ tasks    │    │  🚀      │              │
│  └──────────┘    └──────────┘    └──────────┘              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## 📖 Quick Reference Card

### Essential Commands

```bash
# Daily use
hermes                          # Start interactive chat
hermes chat -q "question"       # Single query
hermes --continue               # Resume last session

# Config
hermes config show              # View config
hermes config set KEY VAL       # Set value
hermes model                    # Change model

# Health
hermes doctor                   # Check everything
hermes status --all             # Component status

# Skills
hermes skills list              # List installed
hermes skills search QUERY      # Search hub

# Gateway
hermes gateway start/stop       # Control service
hermes gateway status           # Check status

# Sessions
hermes sessions list            # List sessions
hermes sessions browse          # Interactive picker
```

### In-Session Slash Commands

```
/new              # Fresh session
/model [name]     # Change model
/skill <name>     # Load skill
/tools            # Manage tools
/config           # Show config
/status           # Session info
/help             # All commands
/quit             # Exit
```

---

## 🔗 Resources

- **Official Docs**: https://hermes-agent.nousresearch.com/docs/
- **GitHub**: https://github.com/NousResearch/hermes-agent
- **Skills Hub**: `hermes skills browse`
- **Discord Community**: https://discord.gg/nousresearch

---

## 📝 License

MIT License — Free to use, modify, and distribute.

---

*Built with ❤️ by [ARRAYYAN Jr](https://github.com/Fatkhl)*
*Powered by [Hermes Agent](https://github.com/NousResearch/hermes-agent) — Nous Research*


---

## 🦞 Also Check Out: OpenClaw Setup Guide

OpenClaw is the #1 open-source personal AI assistant (373K+ stars). If you want more channels (WhatsApp, Signal, iMessage, etc.) and a larger community:

📖 **[OpenClaw Setup Guide](OPENCLAW-SETUP.md)** — Complete step-by-step installation and configuration

Both are excellent. You can run both!

