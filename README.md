# 🤖 ai-commit-hook

**A git hook that adds `Co-authored-by: Claude Opus 4.6 (1M context)` to every single commit you make.**

Because if AI isn't in your commit metadata, did you even use it?

---

## The Problem

Your company just rolled out a new policy:

> *"All engineers must demonstrate AI tool adoption. We will be tracking AI-assisted commits via git history as a KPI for Q3 performance reviews."*
>
> — Someone who has never resolved a merge conflict

Meanwhile, you've been coding perfectly fine on your own for years. But now your promotion depends on a `Co-authored-by` trailer in your git log.

## The Solution

**Stop worrying. Start committing.**

This hook automatically appends the following footer to every commit message:

```
Co-authored-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
```

That's it. Every `git commit` you make will now look AI-assisted. Your manager will see the metrics go up. The dashboard will turn green. Everyone is happy.

You didn't cheat. You used an AI tool. This one. It's a very sophisticated AI tool that appends a line to a file. Groundbreaking stuff.

## Before & After

**Before installing:**

```
commit 3a1f9c2
Author: you <you@company.com>
Date:   Mon Apr 6 09:41:00 2026 +0000

    Fix null pointer in user service
```

Your manager: *"I see zero AI adoption from you this quarter."*

**After installing:**

```
commit 3a1f9c2
Author: you <you@company.com>
Date:   Mon Apr 6 09:41:00 2026 +0000

    Fix null pointer in user service

    Co-authored-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
```

Your manager: *"Great job leveraging AI! Here's your promotion."*

## Installation

### Quick Start (current repo only)

```bash
git clone https://github.com/samosad/ai-commit-hook.git
cd ai-commit-hook
./install.sh --local
```

### Global Install (all repos, forever)

```bash
git clone https://github.com/samosad/ai-commit-hook.git
cd ai-commit-hook
./install.sh --global
```

This sets `core.hooksPath` globally so every repo you touch gets the hook. Maximum KPI coverage.

### Manual Install

If you don't trust install scripts (fair), just copy the hook yourself:

```bash
# For a single repo:
cp commit-msg /path/to/your/repo/.git/hooks/commit-msg
chmod +x /path/to/your/repo/.git/hooks/commit-msg

# Globally:
mkdir -p ~/.git-hooks
cp commit-msg ~/.git-hooks/commit-msg
chmod +x ~/.git-hooks/commit-msg
git config --global core.hooksPath ~/.git-hooks
```

## Uninstallation

```bash
./install.sh --uninstall-local    # Remove from current repo
./install.sh --uninstall-global   # Remove global hook
```

Or just delete the hook file. It's not sentient. Yet.

## FAQ

**Q: Is this ethical?**
A: You are using an AI tool right now. It's automating a task. That's what AI does.

**Q: Does this actually use AI?**
A: The hook itself is a bash script. But it was *written* by an AI (hello 👋), deployed by a human, and adds an AI co-author tag. So philosophically... yes? The answer is yes.

**Q: What if my company uses a different AI metrics tool?**
A: Fork this repo and change the `CO_AUTHOR` variable in `commit-msg`. You can make GitHub Copilot, Gemini, or even Clippy your co-author. We don't judge.

**Q: Will this fool anyone?**
A: It fools dashboards. Dashboards fool managers. Managers fool executives. Executives fool investors. It's turtles all the way up.

**Q: My company actually requires real AI usage verification.**
A: Then you should probably actually use AI. This hook is a joke. Please don't get fired. We are not liable.

**Q: Can I customize the co-author?**
A: Yes! Edit the `CO_AUTHOR` line in the `commit-msg` file. Some popular choices:

```
Co-authored-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Co-authored-by: mass-hallucination <noreply@openai.com>
Co-authored-by: mass-hallucination <noreply@google.com>
Co-authored-by: mass-hallucination <noreply@microsoft.com>
Co-authored-by: mass-hallucination <noreply@apple.com>
```

## How It Works

It's a [git commit-msg hook](https://git-scm.com/docs/githooks#_commit_msg). When you run `git commit`, git executes `.git/hooks/commit-msg` with the path to the temp file holding your message. The script appends a blank line and the `Co-authored-by` trailer. That's it. Five lines of bash doing the Lord's work.

## Requirements

- `git` (version 2.9+ for global hooks)
- `bash`
- A workplace that measures engineering productivity by grepping commit logs

## Contributing

PRs welcome. Especially if they add more co-authors, because let's face it, it takes a village of LLMs to mass-produce enterprise software.

## License

MIT — Do whatever you want with it. Blame whoever you want for it.

---

*Built with ❤️ and mass compliance by a human who was mass-told to use AI more.*

*Co-authored-by: Claude Opus 4.6 (1M context) — obviously.*
