# 🔄 Hermes Agent — Workflow Reference

## The Complete Agent Lifecycle

```
USER INPUT
    │
    ▼
┌─────────────────────────────────────────┐
│         SYSTEM PROMPT ASSEMBLY          │
│                                         │
│  ┌─────────────┐  ┌──────────────────┐  │
│  │  SOUL.md    │  │  Injected Memory │  │
│  │  (Identity) │  │  (User prefs,    │  │
│  │             │  │   env facts)     │  │
│  └─────────────┘  └──────────────────┘  │
│                                         │
│  ┌─────────────┐  ┌──────────────────┐  │
│  │  Skills     │  │  Platform        │  │
│  │  (Loaded    │  │  Context         │  │
│  │   know-how) │  │  (Telegram/Disc) │  │
│  └─────────────┘  └──────────────────┘  │
└─────────────────────────────────────────┘
    │
    ▼
┌─────────────────────────────────────────┐
│            LLM INFERENCE                │
│                                         │
│  Model: claude-sonnet-4 / deepseek /    │
│         gemini / mimo / custom          │
│                                         │
│  Input: System Prompt + Conversation    │
│         History + Tool Schemas          │
│                                         │
│  Output: Text Response OR Tool Calls    │
└─────────────────────────────────────────┘
    │
    ├── TEXT RESPONSE ──▶ Send to User ──▶ DONE
    │
    └── TOOL CALLS ──▶ ┌────────────────────┐
                       │   TOOL DISPATCH     │
                       │                     │
                       │  ┌───────────────┐  │
                       │  │ terminal()    │  │
                       │  │ file ops      │  │
                       │  │ web_search()  │  │
                       │  │ browser_*()   │  │
                       │  │ delegate_task │  │
                       │  │ memory()      │  │
                       │  │ skill_manage  │  │
                       │  │ cronjob()     │  │
                       │  │ send_message  │  │
                       │  └───────────────┘  │
                       └─────────┬───────────┘
                                 │
                                 ▼
                       Tool Results appended
                       to conversation
                                 │
                                 ▼
                       Loop back to LLM
                       (until text response
                        or max turns)
```

---

## How the Agent Gets Smarter Over Time

```
SESSION 1: User asks complex task
    │
    ▼
Agent figures out approach (trial & error)
    │
    ▼
Agent completes task
    │
    ├──▶ MEMORY: Saves user preference
    │    "User prefers Python over Node.js"
    │
    └──▶ SKILL: Saves reusable procedure
         "How to deploy to Vercel with env vars"
              │
              ▼
SESSION 2: User asks similar task
    │
    ▼
Agent loads relevant skill
    │
    ▼
Agent executes with known-good approach
(no trial & error — faster, more reliable)
    │
    ▼
Agent updates skill if it discovers
new pitfalls or better steps
```

---

## Gateway Message Flow

```
┌──────────┐     ┌──────────┐     ┌──────────┐
│ Telegram │     │ Discord  │     │  Slack   │
│ Message  │     │ Message  │     │ Message  │
└────┬─────┘     └────┬─────┘     └────┬─────┘
     │                │                │
     └────────────────┼────────────────┘
                      │
                      ▼
              ┌───────────────┐
              │   GATEWAY     │
              │   (Platform   │
              │    Adapter)   │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │  SESSION      │
              │  MANAGEMENT   │
              │  (SQLite)     │
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │  AGENT LOOP   │
              │  (Same as CLI)│
              └───────┬───────┘
                      │
                      ▼
              ┌───────────────┐
              │  RESPONSE     │
              │  DELIVERY     │
              │  (Back to     │
              │   platform)   │
              └───────────────┘
```

---

## Cron Job Flow

```
┌──────────────┐
│  SCHEDULER   │
│  (Checks     │
│   every 30s) │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Job due?    │──NO──▶ Wait
└──────┬───────┘
       │ YES
       ▼
┌──────────────┐
│  Spawn fresh │
│  agent       │
│  session     │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Execute     │
│  prompt      │
│  (with tools)│
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Deliver     │
│  result to   │
│  target      │
│  (TG/Disc/   │
│   file)      │
└──────────────┘
```

---

## Multi-Agent Delegation Flow

```
┌─────────────────────────────────────┐
│         PARENT AGENT                │
│                                     │
│  Receives complex task              │
│  Breaks into subtasks               │
└──────────────┬──────────────────────┘
               │
    ┌──────────┼──────────┐
    │          │          │
    ▼          ▼          ▼
┌────────┐┌────────┐┌────────┐
│Child A ││Child B ││Child C │
│        ││        ││        │
│Research││Code    ││Test    │
│task    ││task    ││task    │
│        ││        ││        │
│Own     ││Own     ││Own     │
│context ││context ││context │
│Own     ││Own     ││Own     │
│terminal││terminal││terminal│
└───┬────┘└───┬────┘└───┬────┘
    │         │         │
    └─────────┼─────────┘
              │
              ▼
    ┌─────────────────┐
    │  RESULTS        │
    │  (Summaries     │
    │   only — no     │
    │   intermediate  │
    │   data)         │
    └────────┬────────┘
             │
             ▼
    ┌─────────────────┐
    │  PARENT AGENT   │
    │  combines       │
    │  results        │
    │  responds to    │
    │  user           │
    └─────────────────┘
```

---

## Skill Lifecycle

```
┌───────────────┐
│  TASK         │
│  COMPLETED    │
│  (Complex,    │
│   5+ steps)   │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  OFFER TO     │
│  SAVE AS      │
│  SKILL        │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  SKILL.md     │
│  CREATED      │
│               │
│  - Trigger    │
│  - Steps      │
│  - Pitfalls   │
│  - Verify     │
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  NEXT TIME    │
│  Agent loads  │
│  skill        │
│  automatically│
└───────┬───────┘
        │
        ▼
┌───────────────┐
│  SKILL        │
│  UPDATED      │
│  if new       │
│  pitfalls     │
│  discovered   │
└───────────────┘
```
