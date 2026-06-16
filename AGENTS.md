# Dotfiles

This document provides context and instructions for AI coding agents working with this repository.

## Overview

This is a **personal dotfiles repository** for macOS, managed with [chezmoi](https://chezmoi.io). It contains configuration files, shell scripts, and automation for setting up and maintaining a development environment.

### Profiles

The repository supports **two profiles** configured during initial setup:

1. **`personal`**: Personal machine setup
2. **`work`**: Work machine setup

The profile is selected during `chezmoi init` via an interactive prompt and stored in `.chezmoi.yaml.tmpl`. Template files use `{{ if eq .profile "work" }}` and `{{ if eq .profile "personal" }}` conditionals to customize configuration based on the selected profile.

## Repository structure

```
.
├── dot_agents/              # Agent skills (~/.agents/)
│   └── skills/
│       ├── create-readme/
│       └── grill-me/
├── dot_claude/              # Claude Code config (~/.claude/)
│   └── symlink_skills       # symlink → ../.agents/skills
├── dot_config/              # Application configs (~/.config/)
│   ├── starship.toml
│   └── zed/
│       └── private_settings.json
├── dot_gitconfig.tmpl       # Git config (~/.gitconfig)
├── dot_iterm2/              # iTerm2 preferences (~/.iterm2/)
│   └── com.googlecode.iterm2.plist
├── dot_zprofile             # Zsh profile (~/.zprofile)
├── dot_zshrc                # Zsh config (~/.zshrc)
├── run_once_after_setup-system.sh.tmpl
├── run_onchange_brew-packages.sh.tmpl
└── setup.sh
```

## Chezmoi Conventions

### File naming

- `dot_` prefix: creates a `.` file (e.g., `dot_zshrc`: `~/.zshrc`)
- `.tmpl` suffix: template file processed with Go templates
- `private_` prefix: file is not printed in `chezmoi diff` output
- `symlink_` prefix: creates a symlink; file content is the symlink target
- `run_once_` prefix: scripts that run once during chezmoi apply
- `run_onchange_` prefix: scripts that run when their content changes
- `run_once_after_`: runs after other scripts
- `run_once_before_`: runs before other scripts

### Key files

- `.chezmoi.yaml.tmpl`: Chezmoi configuration
- `.chezmoiignore`: Files to ignore by chezmoi
- `setup.sh`: Installation script

## Guidelines

### Making Changes

1. **Template Files**: When editing `.tmpl` files, preserve Go template syntax (e.g., `{{ .chezmoi.* }}`)
2. **Shell Scripts**: Follow existing shell script conventions (zsh compatible)
3. **Testing**: Use `chezmoi diff` to preview changes before applying
4. **Validation**: Run `chezmoi apply --dry-run` to test changes

### Best Practices

- **Preserve existing structure**: Don't reorganize files without explicit request
- **Maintain compatibility**: Changes should work on macOS and unix systems
- **Template variables**: Use chezmoi template variables when appropriate
- **Idempotency**: Scripts should be safe to run multiple times
- **Error handling**: Fail gracefully when writing scripts
- **Comments**: Never add comments

## Development Workflow

When helping with this repository:

1. **Understand the change**: Know if it's a config, script, or template
2. **Locate the correct file**: Use chezmoi naming conventions
3. **Preserve templates**: Keep `{{ }}` syntax intact
4. **Test safely**: Use `--dry-run` flags

## Questions?

- [Chezmoi.io docs](https://chezmoi.io)
