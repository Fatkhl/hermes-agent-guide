# 🦞 OpenClaw — Setup Guide

> Personal AI Assistant — Any OS, Any Platform, The Lobster Way

[![OpenClaw](https://img.shields.io/badge/OpenClaw-🦞-FF6B35?style=for-the-badge&logo=github)](https://github.com/openclaw/openclaw)
[![Stars](https://img.shields.io/github/stars/openclaw/openclaw?style=for-the-badge&logo=github)](https://github.com/openclaw/openclaw)
[![Docs](https://img.shields.io/badge/Docs-Official-22c55e?style=for-the-badge)](https://docs.openclaw.ai)

---

## 📑 Table of Contents

1. [What is OpenClaw?](#-what-is-openclaw)
2. [System Requirements](#-system-requirements)
3. [Installation](#-installation)
4. [Initial Setup (Onboard)](#-initial-setup)
5. [Model & Provider Configuration](#-model--provider-configuration)
6. [Channel Setup (Telegram, Discord, etc.)](#-channel-setup)
7. [Skills System](#-skills-system)
8. [Gateway Management](#-gateway-management)
9. [Security & DM Pairing](#-security--dm-pairing)
10. [Migration from OpenClaw to Hermes](#-migration-openclaw-to-hermes)
11. [Troubleshooting](#-troubleshooting)
12. [Quick Reference](#-quick-reference)

---

## 🤖 What is OpenClaw?

OpenClaw is a **personal AI assistant** you run on your own devices. It's open-source, local-first, and connects to the channels you already use.

**Key Features:**
- 🏠 **Local-first Gateway** — single control plane for sessions, channels, tools
- 📱 **20+ Channels** — WhatsApp, Telegram, Slack, Discord, Signal, iMessage, Google Chat, IRC, Teams, Matrix, WeChat, QQ, and more
- 🧠 **Multi-model support** — OpenAI, Anthropic, Google, DeepSeek, xAI, and 15+ providers
- 🔧 **Skills system** — 5,400+ community skills
- 🎤 **Voice** — speak and listen on macOS/iOS/Android
- 🖼️ **Live Canvas** — render and control visual output
- 🔒 **Secure** — DM pairing, allowlists, local data
- 🤖 **Multi-agent routing** — route channels to isolated agents

**OpenClaw vs Hermes Agent:**

| Feature | OpenClaw | Hermes Agent |
|---------|----------|-------------|
| Language | Node.js (npm) | Python (pip) |
| Stars | 373K+ | Growing |
| Channels | 20+ | 10+ |
| Skills | 5,400+ | Growing |
| Focus | Multi-channel assistant | Coding & automation |
| Community | Large, established | Nous Research |

Both are excellent. OpenClaw has more channels and a larger community. Hermes Agent has deeper coding tool integration. You can run both!

---

## 📋 System Requirements

| Component | Minimum | Recommended |
|-----------|---------|-------------|
| OS | macOS, Linux, Windows (WSL2) | macOS / Ubuntu 22.04+ |
| Node.js | 22.19+ | **24 (recommended)** |
| RAM | 1 GB | 2+ GB |
| Disk | 500 MB free | 2+ GB free |
| Internet | Required | Stable connection |

---

## ⚡ Installation

### One-Line Install (Recommended)

```bash
# Install OpenClaw globally
npm install -g openclaw@latest

# Run the onboard wizard (installs daemon too)
openclaw onboard --install-daemon
```

### Alternative Package Managers

```bash
# pnpm
pnpm add -g openclaw@latest

# bun
bun add -g openclaw@latest
```

### Docker

```bash
docker pull openclaw/openclaw:latest
docker run -d --name openclaw -p 18789:18789 openclaw/openclaw:latest
```

### Nix

```bash
nix run github:openclaw/nix-openclaw
```

---

## 🔧 Initial Setup

### Step 1: Run the Onboard Wizard

```bash
openclaw onboard --install-daemon
```

This guides you through:
- Gateway configuration
- Workspace setup
- Channel connections
- Skill installation
- Model selection

### Step 2: Start the Gateway

```bash
# Foreground (for debugging)
openclaw gateway --port 18789 --verbose

# Or as a daemon (recommended)
openclaw gateway start
```

### Step 3: Verify Installation

```bash
openclaw doctor
```

This checks all dependencies, config validity, and connection status.

---

## 🧠 Model & Provider Configuration

### Set Your Model

```bash
openclaw model
```

Interactive picker for providers and models.

### Supported Providers

| Provider | Auth | Notes |
|----------|------|-------|
| OpenAI | API key / OAuth | GPT-4o, o1, Codex |
| Anthropic | API key | Claude 3.5, Claude 4 |
| Google | API key | Gemini 2.5, Gemini Flash |
| DeepSeek | API key | DeepSeek Chat, DeepSeek Coder |
| xAI | API key | Grok models |
| OpenRouter | API key | 200+ models via one key |
| Local (Ollama) | None | Run models locally |

### Config File

```bash
# Location
~/.openclaw/config.yaml

# Edit
openclaw config edit

# View
openclaw config show
```

### Key Config Options

```yaml
# ~/.openclaw/config.yaml
model:
  provider: openai
  model: gpt-4o
  api_key: sk-xxxxx

# Or via OpenRouter
model:
  provider: openrouter
  model: anthropic/claude-sonnet-4
  api_key: sk-or-xxxxx
```

---

## 📱 Channel Setup

### Telegram

```bash
# 1. Create bot via @BotFather
# 2. Get the bot token
# 3. Add to config
openclaw config set channels.telegram.bot_token YOUR_TOKEN

# 4. Start gateway
openclaw gateway restart
```

### Discord

```bash
# 1. Create bot at discord.com/developers
# 2. Get bot token + application ID
# 3. Configure
openclaw config set channels.discord.bot_token YOUR_TOKEN
openclaw config set channels.discord.application_id YOUR_APP_ID

# 4. Enable Message Content Intent in Discord Developer Portal
# 5. Restart gateway
openclaw gateway restart
```

### WhatsApp

```bash
openclaw whatsapp
```

Interactive WhatsApp setup with QR code scanning.

### Slack

```bash
openclaw config set channels.slack.bot_token xoxb-xxxxx
openclaw config set channels.slack.app_token xapp-xxxxx
openclaw gateway restart
```

### Signal

```bash
openclaw config set channels.signal.enabled true
openclaw gateway restart
```

### Google Chat

```bash
openclaw config set channels.googlechat.enabled true
openclaw gateway restart
```

### All Supported Channels

WhatsApp, Telegram, Slack, Discord, Google Chat, Signal, iMessage, IRC, Microsoft Teams, Matrix, Feishu, LINE, Mattermost, Nextcloud Talk, Nostr, Synology Chat, Tlon, Twitch, Zalo, WeChat, QQ, WebChat

---

## 🧩 Skills System

### Browse Skills

```bash
openclaw skills browse
```

### Install Skills

```bash
# Search
openclaw skills search "docker"

# Install
openclaw skills install <skill-id>

# List installed
openclaw skills list
```

### Popular Skills

```bash
# Web development
openclaw skills install popular-web-designs

# DevOps
openclaw skills install docker-compose

# Research
openclaw skills install arxiv

# Coding
openclaw skills install code-review
```

### Skill Hub

Browse 5,400+ skills at: [clawhub.com](https://clawhub.com)

---

## 🔧 Gateway Management

```bash
# Start
openclaw gateway start

# Stop
openclaw gateway stop

# Restart
openclaw gateway restart

# Status
openclaw gateway status

# Logs
openclaw gateway logs

# Foreground (debug)
openclaw gateway --verbose
```

### Install as System Service

```bash
openclaw onboard --install-daemon
```

This installs a launchd (macOS) or systemd (Linux) service that auto-starts on boot.

---

## 🔒 Security & DM Pairing

### DM Pairing (Default)

By default, unknown senders receive a pairing code. You must approve them:

```bash
openclaw pairing approve telegram CODE
openclaw pairing approve discord CODE
```

### View Pending Pairings

```bash
openclaw pairing list
```

### Open DMs (Not Recommended)

```yaml
# config.yaml
channels:
  telegram:
    dm_policy: open
    allow_from:
      - "*"
```

### Revoke Access

```bash
openclaw pairing revoke telegram USER_ID
```

### Security Check

```bash
openclaw doctor
```

---

## 🔄 Migration: OpenClaw → Hermes Agent

If you want to switch from OpenClaw to Hermes Agent:

```bash
# Install Hermes Agent
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

# Migrate everything
hermes claw migrate --migrate-secrets

# Preview first (dry run)
hermes claw migrate --dry-run

# Cleanup old OpenClaw files
hermes claw cleanup
```

This migrates:
- ✅ Settings & config
- ✅ Memories
- ✅ Skills
- ✅ API keys (with --migrate-secrets)
- ✅ Channel configs

---

## 🔥 Troubleshooting

| Problem | Solution |
|---------|----------|
| `openclaw: command not found` | `npm install -g openclaw@latest` |
| Gateway won't start | `openclaw doctor` → check config |
| Channel not connecting | Check bot token, restart gateway |
| Model errors | `openclaw model` → reconfigure |
| DMs not working | Check pairing: `openclaw pairing list` |
| Voice not working | Check STT/TTS provider config |
| Node version error | Upgrade to Node 24: `nvm install 24` |

### Diagnostic Commands

```bash
openclaw doctor              # Full health check
openclaw status              # Component status
openclaw gateway logs        # View gateway logs
openclaw config show         # View current config
```

---

## 📖 Quick Reference

### Essential Commands

```bash
# Setup
openclaw onboard             # Interactive setup wizard
openclaw model               # Change model/provider
openclaw config show         # View config

# Gateway
openclaw gateway start/stop  # Control gateway
openclaw gateway status      # Check status
openclaw gateway logs        # View logs

# Skills
openclaw skills list         # List installed
openclaw skills search Q     # Search skills
openclaw skills install ID   # Install skill

# Security
openclaw pairing list        # View pairings
openclaw pairing approve     # Approve DM access
openclaw doctor              # Health check

# Messaging
openclaw message send --target TARGET --message "Hello"
openclaw agent --message "Do something"
```

### In-Session Commands

```
/help              # Show all commands
/model [name]      # Change model
/skills            # Browse skills
/config            # Show config
/status            # Session info
/quit              # Exit
```

---

## 🔗 Resources

- **Website**: [openclaw.ai](https://openclaw.ai)
- **Docs**: [docs.openclaw.ai](https://docs.openclaw.ai)
- **GitHub**: [github.com/openclaw/openclaw](https://github.com/openclaw/openclaw)
- **Discord**: [discord.gg/clawd](https://discord.gg/clawd)
- **Skills Hub**: [clawhub.com](https://clawhub.com)
- **DeepWiki**: [deepwiki.com/openclaw/openclaw](https://deepwiki.com/openclaw/openclaw)

---

## 📝 License

MIT License — Free to use, modify, and distribute.

---

*Part of the [Hermes Agent Guide](https://github.com/Fatkhl/hermes-agent-guide) collection*
*Built with ❤️ by [AER](https://github.com/Fatkhl) — ARRAYYAN Jr*
