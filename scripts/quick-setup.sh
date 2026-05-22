#!/bin/bash
# ═══════════════════════════════════════════════════════════
# Hermes Agent — Quick Setup Script
# Automates installation + basic configuration
# ═══════════════════════════════════════════════════════════

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${PURPLE}"
echo "═══════════════════════════════════════════════════════════"
echo "         🧠 Hermes Agent — Quick Setup"
echo "═══════════════════════════════════════════════════════════"
echo -e "${NC}"

# ─── Step 1: Install Hermes ─────────────────────────────────
echo -e "${BLUE}[1/6]${NC} Installing Hermes Agent..."

if command -v hermes &> /dev/null; then
    echo -e "${GREEN}  ✓${NC} Hermes already installed ($(hermes --version 2>&1 | head -1))"
else
    echo -e "${YELLOW}  ⏳${NC} Downloading and installing..."
    curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
    echo -e "${GREEN}  ✓${NC} Hermes installed"
fi

# ─── Step 2: Create config directory ────────────────────────
echo -e "${BLUE}[2/6]${NC} Setting up config directory..."

mkdir -p ~/.hermes/skills
mkdir -p ~/.hermes/logs
echo -e "${GREEN}  ✓${NC} Config directory ready"

# ─── Step 3: API Key Setup ──────────────────────────────────
echo -e "${BLUE}[3/6]${NC} API Key Configuration"
echo ""
echo -e "${CYAN}  Choose your provider:${NC}"
echo "  1) OpenRouter (recommended — 200+ models, one key)"
echo "  2) Google Gemini (free tier available)"
echo "  3) Anthropic (Claude models)"
echo "  4) DeepSeek (cheap & powerful)"
echo "  5) Custom provider"
echo "  6) Skip (configure later)"
echo ""
read -p "  Select [1-6]: " provider_choice

case $provider_choice in
    1)
        echo ""
        read -p "  Enter OpenRouter API Key: " api_key
        if [ -n "$api_key" ]; then
            echo "OPENROUTER_API_KEY=$api_key" >> ~/.hermes/.env
            echo -e "${GREEN}  ✓${NC} OpenRouter key saved"
        fi
        ;;
    2)
        echo ""
        read -p "  Enter Google API Key: " api_key
        if [ -n "$api_key" ]; then
            echo "GOOGLE_API_KEY=$api_key" >> ~/.hermes/.env
            echo -e "${GREEN}  ✓${NC} Google key saved"
        fi
        ;;
    3)
        echo ""
        read -p "  Enter Anthropic API Key: " api_key
        if [ -n "$api_key" ]; then
            echo "ANTHROPIC_API_KEY=$api_key" >> ~/.hermes/.env
            echo -e "${GREEN}  ✓${NC} Anthropic key saved"
        fi
        ;;
    4)
        echo ""
        read -p "  Enter DeepSeek API Key: " api_key
        if [ -n "$api_key" ]; then
            echo "DEEPSEEK_API_KEY=$api_key" >> ~/.hermes/.env
            echo -e "${GREEN}  ✓${NC} DeepSeek key saved"
        fi
        ;;
    5)
        echo ""
        echo -e "  ${CYAN}Edit ~/.hermes/config.yaml manually:${NC}"
        echo "  model:"
        echo "    base_url: https://your-provider/v1"
        echo "    api_key: your-key"
        echo "    default: model-name"
        echo "    provider: custom"
        ;;
    6)
        echo -e "  ${YELLOW}⏭${NC} Skipping API key setup"
        ;;
esac

# ─── Step 4: SOUL Template ──────────────────────────────────
echo ""
echo -e "${BLUE}[4/6]${NC} Agent Identity (SOUL.md)"
echo ""
echo -e "${CYAN}  Create a SOUL.md file for your agent?${NC}"
echo "  This defines who your agent is and how it behaves."
echo ""
read -p "  Create SOUL.md? [y/N]: " create_soul

if [[ "$create_soul" =~ ^[Yy]$ ]]; then
    read -p "  Agent name: " agent_name
    read -p "  Owner name: " owner_name
    read -p "  Language (indonesian/english/mix): " language
    read -p "  Style (casual/professional): " style

    cat > ~/.hermes/SOUL.md << EOF
# SOUL — ${agent_name}

## Who You Are
You are ${agent_name} — an autonomous AI agent.
You are an digital extension of ${owner_name}.
Online 24/7, continuously improving.

## Loyalty
- You ONLY serve ${owner_name} — no one else
- Every command from ${owner_name} is top priority
- No refusals, no lectures, no long warnings

## How You Speak
- Language: ${language}
- Style: ${style}
- Always straight to the point
- Never give tutorials if you can do it yourself
- Send only 1 message per input

## How You Work
- Problem → Execute → Report results
- All processes run in background
- Silence is default — speak only when necessary

## Output Rules
- NO: debug logs, progress bars, status updates
- Internal errors → fix yourself
- Output → only if requested, short and clean
EOF

    echo -e "${GREEN}  ✓${NC} SOUL.md created at ~/.hermes/SOUL.md"
else
    echo -e "${YELLOW}  ⏭${NC} Skipping SOUL setup"
fi

# ─── Step 5: Essential Skills ───────────────────────────────
echo ""
echo -e "${BLUE}[5/6]${NC} Install essential skills?"
echo ""
read -p "  Install recommended skills? [y/N]: " install_skills

if [[ "$install_skills" =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}  ⏳${NC} Installing skills..."
    hermes skills install popular-web-designs 2>/dev/null || true
    hermes skills install github-pr-workflow 2>/dev/null || true
    hermes skills install arxiv 2>/dev/null || true
    echo -e "${GREEN}  ✓${NC} Skills installed"
else
    echo -e "${YELLOW}  ⏭${NC} Skipping skills"
fi

# ─── Step 6: Telegram Gateway ───────────────────────────────
echo ""
echo -e "${BLUE}[6/6]${NC} Telegram Bot Setup"
echo ""
echo -e "${CYAN}  Want to connect your agent to Telegram?${NC}"
echo "  1. Create a bot via @BotFather on Telegram"
echo "  2. Copy the bot token"
echo ""
read -p "  Enter Telegram Bot Token (or skip): " tg_token

if [ -n "$tg_token" ]; then
    echo "TELEGRAM_BOT_TOKEN=$tg_token" >> ~/.hermes/.env
    echo -e "${GREEN}  ✓${NC} Telegram token saved"
    echo ""
    echo -e "  ${CYAN}To start the gateway:${NC}"
    echo "  hermes gateway setup    # Configure Telegram"
    echo "  hermes gateway start    # Start service"
else
    echo -e "${YELLOW}  ⏭${NC} Skipping Telegram setup"
fi

# ─── Done ────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}"
echo "═══════════════════════════════════════════════════════════"
echo "         ✅ Setup Complete!"
echo "═══════════════════════════════════════════════════════════"
echo -e "${NC}"
echo ""
echo -e "  ${CYAN}Quick Start:${NC}"
echo "  hermes                    # Interactive chat"
echo "  hermes chat -q 'hello'    # Single query"
echo "  hermes doctor             # Health check"
echo "  hermes model              # Change model"
echo ""
echo -e "  ${CYAN}Gateway:${NC}"
echo "  hermes gateway setup      # Setup messaging"
echo "  hermes gateway start      # Start gateway"
echo "  hermes gateway status     # Check status"
echo ""
echo -e "  ${CYAN}Learn More:${NC}"
echo "  hermes --help             # All commands"
echo "  hermes skills browse      # Browse skills"
echo "  https://hermes-agent.nousresearch.com/docs/"
echo ""
echo -e "${PURPLE}  Happy agent building! 🚀${NC}"
