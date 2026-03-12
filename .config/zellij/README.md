# Zellij Configuration

A customized Zellij terminal multiplexer setup with tmux-compatible keybindings, vim-style navigation, and fzf-powered session switching.

## Quick Reference

| Action | Keybinding |
|--------|------------|
| Enter Tmux mode | `Ctrl+B` |
| Enter Session mode | `Ctrl+O` |
| Enter Pane mode | `Ctrl+P` |
| Enter Tab mode | `Ctrl+T` |
| Enter Resize mode | `Ctrl+N` |
| Enter Move mode | `Ctrl+H` |
| Enter Scroll mode | `Ctrl+S` |
| Lock/Unlock | `Ctrl+G` |
| Quit Zellij | `Ctrl+Q` |
| Return to Normal | `Enter` or `Esc` |

## Mode Switching

Zellij uses a modal interface. Press the mode key to enter a mode, then use mode-specific keybindings. Press `Enter` or `Esc` to return to Normal mode.

```
Normal ─┬─ Ctrl+B ──► Tmux Mode (tmux-compatible commands)
        ├─ Ctrl+O ──► Session Mode (session management)
        ├─ Ctrl+P ──► Pane Mode (pane operations)
        ├─ Ctrl+T ──► Tab Mode (tab operations)
        ├─ Ctrl+N ──► Resize Mode (resize panes)
        ├─ Ctrl+H ──► Move Mode (move panes)
        ├─ Ctrl+S ──► Scroll Mode (scrollback navigation)
        └─ Ctrl+G ──► Locked Mode (disable all bindings)
```

## Keybindings by Mode

### Tmux Mode (`Ctrl+B`)

Familiar tmux-style keybindings for users transitioning from tmux.

| Key | Action |
|-----|--------|
| `s` | **Session Picker** (fzf-powered project switcher) |
| `c` | New tab |
| `n` | Next tab |
| `p` | Previous tab |
| `,` | Rename tab |
| `"` | Split pane down |
| `%` | Split pane right |
| `x` | Close focused pane |
| `z` | Toggle fullscreen |
| `h/j/k/l` | Navigate panes (vim-style) |
| `Arrow keys` | Navigate panes |
| `o` | Focus next pane |
| `d` | Detach from session |
| `Space` | Next layout |
| `[` | Enter scroll mode |
| `Ctrl+B` | Send literal Ctrl+B |

### Session Mode (`Ctrl+O`)

| Key | Action |
|-----|--------|
| `w` | Open session manager (built-in plugin) |
| `d` | Detach from session |
| `c` | Open configuration plugin |
| `p` | Open plugin manager |
| `a` | About Zellij |
| `s` | Share session |
| `Ctrl+S` | Enter scroll mode |

### Pane Mode (`Ctrl+P`)

| Key | Action |
|-----|--------|
| `n` | New pane (auto direction) |
| `d` | New pane down |
| `r` | New pane right |
| `s` | New stacked pane |
| `x` | Close focused pane |
| `f` | Toggle fullscreen |
| `z` | Toggle pane frames |
| `w` | Toggle floating panes |
| `e` | Toggle embed/floating |
| `c` | Rename pane |
| `i` | Toggle pane pinned |
| `p` | Switch focus |
| `h/j/k/l` | Navigate panes (vim-style) |

### Tab Mode (`Ctrl+T`)

| Key | Action |
|-----|--------|
| `n` | New tab |
| `x` | Close tab |
| `r` | Rename tab |
| `h/k` or `Left/Up` | Previous tab |
| `l/j` or `Right/Down` | Next tab |
| `1-9` | Go to tab by number |
| `Tab` | Toggle between last two tabs |
| `s` | Sync tab (send input to all panes) |
| `b` | Break pane to new tab |
| `]` | Break pane right |
| `[` | Break pane left |

### Resize Mode (`Ctrl+N`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Increase size in direction |
| `H/J/K/L` | Decrease size in direction |
| `+` or `=` | Increase overall size |
| `-` | Decrease overall size |

### Move Mode (`Ctrl+H`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move pane in direction |
| `n` or `Tab` | Move pane forward |
| `p` | Move pane backward |

### Scroll Mode (`Ctrl+S`)

| Key | Action |
|-----|--------|
| `j/k` | Scroll down/up |
| `d/u` | Half page down/up |
| `Ctrl+F/Ctrl+B` | Page down/up |
| `s` | Enter search mode |
| `e` | Edit scrollback in `$EDITOR` |
| `Ctrl+C` | Scroll to bottom and exit |

### Search Mode (from Scroll mode, press `s`)

| Key | Action |
|-----|--------|
| `n` | Next match |
| `p` | Previous match |
| `c` | Toggle case sensitivity |
| `w` | Toggle wrap |
| `o` | Toggle whole word |

### Locked Mode (`Ctrl+G`)

All keybindings are disabled except `Ctrl+G` to unlock.

## Global Shortcuts

These work in all modes except Locked:

| Keybinding | Action |
|------------|--------|
| `Ctrl+Shift+F` | Toggle floating panes |
| `Ctrl+Shift+N` | New pane |
| `Ctrl+Shift+H/L` | Focus or switch tab left/right |
| `Ctrl+Shift+J/K` | Focus pane down/up |
| `Ctrl+Shift+I/O` | Move tab left/right |
| `Ctrl+Shift+=` | Increase pane size |
| `Ctrl+Shift+-` | Decrease pane size |
| `Ctrl+Shift+[/]` | Previous/next layout |
| `Ctrl+Shift+P` | Toggle pane in group |
| `Ctrl+Shift+Alt+P` | Toggle group marking |
| `Ctrl+Q` | Quit Zellij |

## Session Switching with zellij-sessionizer

Press `Ctrl+B S` to open the fzf-powered session picker. This allows you to:

- Fuzzy search through your project directories
- See session status (current, active, exited)
- Create new sessions for projects
- Switch between existing sessions

### How It Works

1. Scans configured directories for projects
2. Shows projects with their session status:
   - Green `(current)` - you're in this session
   - Yellow `(active)` - session is running
   - Red `(exited)` - session can be resurrected
3. Select a project to switch to or create a new session
4. Uses [zellij-switch](https://github.com/mostafaqanbaryan/zellij-switch) plugin for in-session switching

### Session Picker Keybindings

| Key | Action |
|-----|--------|
| `Enter` | Select project/session |
| `Ctrl+D` | Delete session |
| `Ctrl+K` | Kill session |
| Type | Fuzzy search |

### Configuration

Environment variables in `~/.config/zsh/envs`:

```bash
# Directories to search (one level deep)
export ZELLIJ_SESSIONIZER_SEARCH_PATHS="$HOME/Repos $HOME/Work"

# Specific directories to always include
export ZELLIJ_SESSIONIZER_SPECIFIC_PATHS="$HOME/.config"
```

## Configuration Settings

Current settings in `config.kdl`:

| Setting | Value | Description |
|---------|-------|-------------|
| `theme` | `catppuccin-mocha` | Color theme |
| `mouse_mode` | `true` | Enable mouse support |
| `copy_on_select` | `true` | Auto-copy selected text |
| `simplified_ui` | `true` | Cleaner UI without special fonts |
| `pane_frames` | `false` | No borders around panes |

## File Structure

```
~/.config/zellij/
├── config.kdl              # Main configuration
└── README.md               # This documentation

~/.local/bin/
└── zellij-sessionizer      # fzf-powered session switcher
```

## Plugins

Built-in plugins configured:

- `session-manager` - Session management UI (`Ctrl+O W`)
- `configuration` - Settings UI (`Ctrl+O C`)
- `plugin-manager` - Plugin management (`Ctrl+O P`)
- `strider` - File picker
- `compact-bar` / `status-bar` - Status bars

## Tips

1. **Quick session switch**: `Ctrl+B S` opens the fuzzy finder for fast project switching
2. **Tmux habits**: Most tmux commands work with `Ctrl+B` prefix
3. **Vim navigation**: Use `h/j/k/l` in most modes for navigation
4. **Scroll history**: `Ctrl+S` then `e` opens scrollback in your editor
5. **Lock when presenting**: `Ctrl+G` prevents accidental keypresses
6. **Tab numbers**: In Tab mode, press `1-9` to jump directly to a tab

## Dependencies

- [zellij](https://zellij.dev/) >= 0.43.1
- [fzf](https://github.com/junegunn/fzf) - For session picker
- [zellij-switch](https://github.com/mostafaqanbaryan/zellij-switch) - Auto-downloaded on first use

## References

- [Zellij Documentation](https://zellij.dev/documentation/)
- [zellij-sessionizer](https://github.com/victor-falcon/zellij-sessionizer)
- [zellij-switch plugin](https://github.com/mostafaqanbaryan/zellij-switch)
