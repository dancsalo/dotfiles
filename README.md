# Salo's Dot Files

These are config files to set up Mac OS X command line the way I like it using [Zsh](https://www.zsh.org).

This repo was originally forked from [Ryan Bates' dotfiles](https://github.com/ryanb/dotfiles).

For an older version of the original repo that uses [Oh My Zsh](https://github.com/robbyrussell/oh-my-zsh), check out [this branch](https://github.com/ryanb/dotfiles/tree/oh-my-zsh).


## Prerequisites

Before running `bin/install`, install the apps and command-line tools that the installer does not manage. Agents can reference the included `Brewfile` for the full Homebrew dependency list, or install everything with:

```sh
brew bundle --file Brewfile
```

Required and optional tools include:

- [Homebrew](https://brew.sh/) for installing command-line tools on macOS.
- [Zsh](https://www.zsh.org/) as your login shell.
- [Starship](https://starship.rs/) for the shell prompt:

  ```sh
  brew install starship
  ```

- [Ghostty](https://ghostty.org/) as the terminal app:

  ```sh
  brew install --cask ghostty
  ```
- [AeroSpace](https://github.com/nikitabobko/AeroSpace) if you want to use the included tiling window manager config:

  ```sh
  brew install --cask nikitabobko/tap/aerospace
  ```

- Optional tools used by shell helpers, such as `fzf`, `ripgrep`, [Atuin](https://atuin.sh/) for searchable shell history, `jp` for inspecting JSON, and `yq` for inspecting YAML:

  ```sh
  brew install fzf ripgrep atuin jp yq
  ```

After installing Starship or Atuin, open a new terminal window or run `exec zsh` so `.zshrc` can initialize them. Atuin adds searchable history on `Ctrl-r`.


## Installation

Run the `bin/install` command to copy files over. It will prompt you before replacing if the files already exist.

```sh
git clone git@github.com/ryanb/dotfiles ~/.dotfiles
cd ~/.dotfiles
./bin/install
```

After installing, open a new terminal window to see the effects.

Feel free to customize the .zshrc file to match your preference.


## Features

I normally place all of my coding projects in ~/code, so this directory can easily be accessed (and tab completed) with the "c" command.

```sh
c railsca<tab>
```

If you don't specify an argument it will open `fzf` allowing you to fuzzy-find code directories. You can add directories to this with CODE_PATH. Just ensure the first one is the base one.

```sh
# in .zshrc
export CODE_PATH="$HOME/code:$HOME/code/railscasts-episodes"
```

There is also an "h" command which behaves similar, but acts on the home path.

```sh
h doc<tab>
```

If you're using git, you'll notice the current branch name shows up in the prompt while in a git repository.

Use `gw` to switch branches with `fzf`. If the branch is checked out in a worktree, it will `cd` there instead.


## Claude Code

The `claude/` directory is a [Claude Code plugin](https://code.claude.com/docs/en/plugins.md) with the following skills:

- **bisect** — Git bisect to find the first bad commit by running a test command
- **dependabot-prs** — Review and merge open Dependabot pull requests
- **fix-all** — Run bin/claude-review --print and automatically fix all reported issues
- **gfix** — Amend a commit further back in history with fixup + auto-rebase
- **interview** — Stress-test a plan or design by interviewing you one numbered, multiple-choice question at a time
- **pr-feedback** — Triage unresolved PR review comments and address each in a separate sub-agent and commit
- **pr-pending-feedback** — Triage pending (unsubmitted) PR review comments and address each in a separate sub-agent and commit
- **rebase** — Interactive rebase workflow
- **remote-diff** — Compare local vs remote branch to detect rebase/merge mistakes
- **review-queue** — Ranked PR review list with dependency trees and filtered line counts
- **standup** — Summarize work since the last standup across your configured repos
- **walkthrough** — Walk through PR changes from the user's perspective

### Installing as a plugin

```sh
/plugin marketplace add ryanb/dotfiles
/plugin install bisect@ryanb-dotfiles
/plugin install gfix@ryanb-dotfiles
/plugin install review-queue@ryanb-dotfiles
```

### dependabot-prs preferences

Create `~/.claude/dependabot-prs.json` to give per-repo instructions to the skill (e.g. limit to certain labels):

```json
{
  "owner/repo": "Only handle PRs with the javascript label."
}
```

### review-queue preferences

Create `~/.claude/review-queue.json` to customize which PRs are prioritized per repo:

```json
{
  "owner/repo": "Prioritize POS PRs. Exclude my PRs (author: username) that are not yet approved."
}
```

### standup preferences

Create `~/.claude/standup.json` to point the skill at your project directory and optionally customize the output:

```json
{
  "base_path": "~/code/your-project-root",
  "default_branch": "main",
  "preferences": "Prefix each section with the team name. Skip WIP branches."
}
```

Only `base_path` is required. The skill writes the last-run timestamp to `~/.claude/standup-last-timestamp` so reruns only show new work since the previous run.


## Uninstall

To remove the dotfile configs, run the following commands. Be certain to double check the contents of the files before removing so you don't lose custom settings.

```
unlink ~/.bin
unlink ~/.gitignore
unlink ~/.gitconfig
unlink ~/.gemrc
unlink ~/.gvimrc
unlink ~/.irbrc
unlink ~/.vim
unlink ~/.vimrc
rm ~/.zshrc # careful here
rm -rf ~/.dotfiles
```

Then open a new terminal window to see the effects.
