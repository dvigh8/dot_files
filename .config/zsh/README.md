# Zsh Configuration Reference

A modular zsh configuration with extensive aliases, functions, and tool integrations.

## Dependencies

The following tools are required for full functionality. Run `install.sh` to install them on macOS or Arch Linux.

| Tool | Purpose |
|------|---------|
| `eza` | Modern `ls` replacement with icons and git integration |
| `bat` | Modern `cat` replacement with syntax highlighting |
| `delta` | Modern `diff` replacement with syntax highlighting |
| `zoxide` | Smarter `cd` that learns your habits |
| `fzf` | Fuzzy finder for files, history, and more |
| `ripgrep` | Fast recursive search (`rg`) |
| `starship` | Cross-shell prompt |
| `lazygit` | Terminal UI for git |
| `yazi` | Terminal file manager |
| `lf` | Terminal file manager (alternative) |
| `neovim` | Modern vim |
| `mise` | Runtime version manager (node, python, etc.) |
| `1password-cli` | 1Password CLI (`op`) for secrets management |
| `imagemagick` | Image conversion and manipulation |
| `ffmpeg` | Video transcoding |
| `uv` | Fast Python package manager |
| `zellij` | Terminal multiplexer |

---

## Quick Reference

### File System & Navigation

| Command | Description | Source |
|---------|-------------|--------|
| `ls` | List files (long format, dirs first, icons) | `aliases:3` |
| `lsa` | List all files including hidden | `aliases:4` |
| `lt` | Tree view (2 levels, with git status) | `aliases:5` |
| `lta` | Tree view including hidden files | `aliases:6` |
| `lst [n]` | Tree listing with optional depth | `functions:20` |
| `cd <path>` | Smart cd (uses zoxide for queries) | `aliases:10` |
| `..` | Go up one directory | `aliases:11` |
| `...` | Go up two directories | `aliases:12` |
| `....` | Go up three directories | `aliases:13` |
| `y [path]` | Open yazi, cd to exit directory | `functions:11` |
| `te` | Open lf, cd to exit directory | `aliases:52` |

### Git & Version Control

| Command | Description | Source |
|---------|-------------|--------|
| `g` | Open lazygit | `aliases:16` |
| `lz` | Open lazygit | `aliases:17` |
| `gcm "msg"` | Git commit with message | `aliases:18` |
| `gcam "msg"` | Git add all and commit | `aliases:19` |
| `gcad` | Amend last commit (all changes) | `aliases:20` |
| `config` | Git commands for dotfiles repo | `aliases:32` |
| `dot` | Lazygit for dotfiles (tracked only) | `aliases:33` |
| `dotall` | Lazygit for dotfiles (show untracked) | `aliases:34` |

### Editors

| Command | Description | Source |
|---------|-------------|--------|
| `vi` | Open neovim | `aliases:23` |
| `n [file]` | Open neovim (defaults to current dir) | `functions:2` |

### Python & Virtual Environments

| Command | Description | Source |
|---------|-------------|--------|
| `venv` | Find and activate nearest venv | `aliases:55` |
| `dvenv` | Deactivate current venv | `functions:98` |
| `uvi <pkg>` | `uv pip install` | `aliases:61` |
| `uvie` | `uv pip install -e .` (editable) | `aliases:62` |
| `uvr <cmd>` | `uv run` | `aliases:63` |
| `uvs` | `uv sync` | `aliases:64` |
| `uva <pkg>` | `uv add` | `aliases:65` |
| `uvad <pkg>` | `uv add --dev` | `aliases:66` |
| `uvl` | `uv lock` | `aliases:67` |

### Data Directory Management

| Command | Description | Source |
|---------|-------------|--------|
| `ddd` | Print data directory path | `aliases:37` |
| `cdd` | cd to data directory | `aliases:38` |
| `ydd` | Open yazi in data directory | `aliases:39` |
| `mvtdd <files>` | Move files to data directory | `functions:155` |
| `lsdd [subdir]` | List data directory contents | `functions:169` |

### Docker & Cloud Tools

| Command | Description | Source |
|---------|-------------|--------|
| `d` | Docker | `aliases:26` |
| `db` | Databricks CLI | `aliases:27` |
| `dbb` | Databricks bundle | `aliases:28` |
| `workflow` | GCloud Dataproc workflow-templates | `aliases:29` |

### Media Processing

| Command | Description | Source |
|---------|-------------|--------|
| `heic` | Convert all .heic to .jpg in current dir | `aliases:49` |
| `c_heic` | Convert .heic to .jpg (5MB limit) | `functions:189` |
| `img2jpg <img>` | Convert image to optimized JPG | `functions:201` |
| `img2jpg-small <img>` | Convert to JPG, max 1080px wide | `functions:207` |
| `img2png <img>` | Convert to optimized PNG | `functions:213` |
| `transcode-video-1080p <vid>` | Transcode video to 1080p H.264 | `functions:224` |
| `transcode-video-4K <vid>` | Transcode video to 4K H.265 | `functions:228` |
| `compress <dir>` | Create .tar.gz archive | `functions:196` |
| `decompress <file>` | Extract .tar.gz archive | `aliases:46` |

### Network & Processes

| Command | Description | Source |
|---------|-------------|--------|
| `ports` | List all listening TCP ports | `aliases:72` |
| `killport <port>` | Kill process on specified port | `functions:279` |

### 1Password Secrets

| Command | Description | Source |
|---------|-------------|--------|
| `op_sync` | Sync global secrets to cache | `op-secrets:33` |
| `op_sync_project [name]` | Sync project secrets to cache | `op-secrets:54` |
| `op_load_project [name]` | Load project secrets into env | `op-secrets:94` |
| `op_unload_project` | Unload current project secrets | `op-secrets:121` |
| `op_status` | Show secrets status and cache age | `op-secrets:132` |

### Shell Management

| Command | Description | Source |
|---------|-------------|--------|
| `rzsh` | Reload zsh configuration | `aliases:42` |
| `ezsh` | Edit zsh config directory | `aliases:43` |

### Terminal Multiplexer

| Command | Description | Source |
|---------|-------------|--------|
| `za` | Attach to zellij session | `aliases:58` |

### Search

| Command | Description | Source |
|---------|-------------|--------|
| `ff <pattern>` | Ripgrep search with line numbers | `functions:40` |

### Modern CLI Replacements

| Command | Description | Source |
|---------|-------------|--------|
| `cat` | Uses `bat` (no paging) | `aliases:69` |
| `diff` | Uses `delta` | `aliases:70` |

### Linux-Only Commands

| Command | Description | Source |
|---------|-------------|--------|
| `open <file>` | Open with default application (xdg-open) | `functions:234` |
| `iso2sd <iso> <device>` | Write ISO to SD card/USB | `functions:238` |
| `format-drive <device> <name>` | Format drive as exFAT | `functions:250` |

---

## Detailed Reference

### File System & Navigation

#### eza (ls replacement)

```bash
ls              # Long format, directories first, with icons
lsa             # Same as ls, but includes hidden files
lt              # Tree view, 2 levels deep, with git status
lta             # Tree view including hidden files
lst             # List with git status (no tree)
lst 3           # Tree view, 3 levels deep
```

**Source:** `aliases:2-7`, `functions:20-26`

#### Smart cd (zoxide integration)

The `cd` command is wrapped to use zoxide for intelligent directory jumping:

```bash
cd              # Go to home directory
cd /path/to/dir # Standard cd for existing paths
cd proj         # Zoxide query - jumps to most frecent match
..              # Go up one level
...             # Go up two levels
....            # Go up three levels
```

When zoxide jumps to a directory, it displays the icon and full path.

**Source:** `aliases:10-13`, `functions:29-37`

#### File Managers

**Yazi** - Opens yazi file manager and changes to the exit directory:

```bash
y               # Open yazi in current directory
y /some/path    # Open yazi in specified path
```

**lf** - Similar behavior with lf file manager:

```bash
te              # Open lf, cd to exit directory
```

**Source:** `functions:11-17`, `aliases:52`

---

### Git & Version Control

#### Lazygit

```bash
g               # Open lazygit
lz              # Open lazygit (alternative)
```

#### Git Shortcuts

```bash
gcm "message"   # git commit -m "message"
gcam "message"  # git commit -a -m "message" (add all + commit)
gcad            # git commit -a --amend (amend with all changes)
```

**Source:** `aliases:16-20`

#### Dotfiles Management

Uses a bare git repository at `~/.dotfiles/` to track dotfiles:

```bash
config status           # Show dotfiles status
config add ~/.zshrc     # Stage a dotfile
config commit -m "msg"  # Commit changes

dot                     # Open lazygit for dotfiles (tracked files only)
dotall                  # Open lazygit showing untracked files too
```

**Source:** `aliases:32-34`

---

### Editors

#### Neovim

```bash
vi              # Open neovim
n               # Open neovim in current directory
n file.py       # Open specific file
n file1 file2   # Open multiple files
```

The `n` function defaults to opening the current directory (`.`) when called without arguments.

**Source:** `aliases:23`, `functions:2-8`

---

### Python & Virtual Environments

#### Virtual Environment Management

```bash
venv            # Find and activate nearest venv
dvenv           # Deactivate current venv
```

The `venv` command searches upward from the current directory for:
- `.venv/`
- `venv/`
- `.virtualenv/`
- `virtualenv/`

When activated, it sets `VENV_PROJECT` for Starship prompt display. For git worktrees, it shows `reponame-worktreename`.

**Source:** `aliases:55`, `functions:44-106`

#### uv (Python Package Manager)

```bash
uvi requests    # uv pip install requests
uvie            # uv pip install -e . (editable install)
uvr pytest      # uv run pytest
uvs             # uv sync (install from lockfile)
uva requests    # uv add requests (add to pyproject.toml)
uvad pytest     # uv add --dev pytest (add as dev dependency)
uvl             # uv lock (update lockfile)
```

**Source:** `aliases:61-67`

---

### Data Directory Management

The data directory system keeps large data files outside of git repositories while maintaining project association.

#### How It Works

1. Searches upward for an existing `data/` directory
2. If not found, creates `../data/<repo-name>/` adjacent to the git root
3. Can be overridden with `DATA_DIR` environment variable

#### Commands

```bash
ddd             # Print the data directory path
cdd             # cd to the data directory
ydd             # Open yazi in the data directory

mvtdd file.csv  # Move file to data directory
mvtdd *.parquet # Move multiple files

lsdd            # List data directory contents
lsdd raw        # List specific subdirectory
```

#### Example Structure

```
~/projects/
├── myproject/          # Git repo
│   ├── src/
│   └── .git/
└── data/
    └── myproject/      # Data directory (auto-created)
        ├── raw/
        └── processed/
```

**Source:** `aliases:37-39`, `functions:109-186`

---

### Docker & Cloud Tools

```bash
d               # docker
d ps            # docker ps
d compose up    # docker compose up

db              # databricks
db workspace ls # databricks workspace ls

dbb             # databricks bundle
dbb deploy      # databricks bundle deploy

workflow        # gcloud dataproc workflow-templates
workflow list   # List workflow templates
```

**Source:** `aliases:26-29`

---

### Media Processing

#### HEIC to JPG Conversion

```bash
heic            # Convert all .heic files in current directory to .jpg
c_heic          # Same, but limits output to 5MB per file
```

**Source:** `aliases:49`, `functions:189-193`

#### Image Optimization

```bash
img2jpg photo.png           # Convert to optimized JPG (95% quality)
img2jpg photo.png -resize 50%  # With ImageMagick options

img2jpg-small photo.png     # Convert to JPG, max width 1080px

img2png screenshot.jpg      # Convert to optimized PNG
```

Output files are named `<original>-optimized.<ext>`.

**Source:** `functions:201-221`

#### Video Transcoding

```bash
transcode-video-1080p video.mov   # H.264, 1080p, fast preset
# Output: video-1080p.mp4

transcode-video-4K video.mov      # H.265, original resolution, slow preset
# Output: video-optimized.mp4
```

**Source:** `functions:224-230`

#### Compression

```bash
compress myfolder       # Creates myfolder.tar.gz
decompress archive.tar.gz  # Extracts archive
```

**Source:** `functions:196-198`, `aliases:46`

---

### Network & Processes

#### List Listening Ports

```bash
ports
# Output:
# COMMAND   PID   USER   FD   TYPE   DEVICE   NODE NAME
# node      1234  david  23u  IPv4   0x...    TCP *:3000 (LISTEN)
```

#### Kill Process on Port

```bash
killport 3000           # Kill whatever is running on port 3000
killport 8080           # Kill process on port 8080
```

**Source:** `aliases:72`, `functions:279-292`

---

### 1Password Secrets Management

A caching system for 1Password secrets that loads them into environment variables.

#### Global Secrets

Global secrets are defined in `OP_GLOBAL_ITEMS` (default: `Avidity:CLI-Global`):

```bash
op_sync         # Fetch and cache global secrets from 1Password
op_load_global  # Load cached global secrets (auto-syncs if stale)
```

Global secrets are automatically loaded on shell startup.

**Source:** `op-secrets:33-92`

#### Project Secrets

Project-specific secrets can be loaded manually or automatically:

```bash
op_sync_project myproject   # Fetch and cache project secrets
op_load_project myproject   # Load project secrets into environment
op_unload_project           # Unload current project secrets
```

**Source:** `op-secrets:54-130`

#### Automatic Project Loading

Create a `.op-project` file in your project root containing the 1Password item name:

```bash
echo "MyProject-Secrets" > /path/to/project/.op-project
```

When you `cd` into a directory with a `.op-project` file (or any subdirectory), the secrets are automatically loaded.

Format options for item names:
- `ItemName` - Uses default vault
- `VaultName:ItemName` - Specifies vault explicitly

**Source:** `op-secrets:112-164`

#### Status and Cache

```bash
op_status
# Output:
# 1Password Secrets Status
# ========================
# Global secrets: 5 loaded (cached 45m ago)
# Project secrets: myproject (3 vars, cached 120m ago)
# Cache TTL: 24h
```

Cache is stored in `~/.cache/op-secrets/` with 600 permissions. TTL is 24 hours.

**Source:** `op-secrets:132-155`

---

### Shell Management

```bash
rzsh            # Reload zsh configuration (source ~/.zshrc)
ezsh            # Open ~/.config/zsh/ in $EDITOR
```

**Source:** `aliases:42-43`

---

### Key Bindings

The shell uses vi-mode with select emacs-style bindings restored for convenience.

#### Mode

Vi-mode is enabled with a 10ms key timeout for responsive mode switching.

#### Navigation & Editing

| Binding | Action |
|---------|--------|
| `Ctrl+A` | Beginning of line |
| `Ctrl+E` | End of line (or fzf-cd if fzf loaded) |
| `Ctrl+K` | Kill to end of line |
| `Ctrl+U` | Kill whole line |
| `Ctrl+W` | Kill word backward |
| `Ctrl+Y` | Yank (paste killed text) |
| `Ctrl+?` / `Ctrl+H` | Backspace |
| `Ctrl+[[3~` | Delete |
| `Ctrl+←` | Word backward |
| `Ctrl+→` | Word forward |

#### History

| Binding | Action |
|---------|--------|
| `Ctrl+P` | Previous history |
| `Ctrl+N` | Next history |
| `↑` | History substring search up |
| `↓` | History substring search down |
| `Ctrl+R` | FZF history search |

#### FZF Integration

| Binding | Action |
|---------|--------|
| `Ctrl+R` | Fuzzy search command history |
| `Ctrl+T` | Fuzzy find and insert file path |
| `Ctrl+E` | Fuzzy find and cd to directory |

**Source:** `shell:33-54`, `plugins:10-11`, `init:33-35`

---

### Terminal Multiplexer

#### Zellij

```bash
za              # Attach to existing zellij session
za mysession    # Attach to named session
```

**Source:** `aliases:58`

---

### Search

#### Ripgrep Wrapper

```bash
ff "pattern"              # Search for pattern in current directory
ff "TODO|FIXME"           # Regex search
ff -i "error"             # Case insensitive
ff "function" --type py   # Search only Python files
```

All ripgrep options are passed through.

**Source:** `functions:40-42`

---

### Modern CLI Replacements

These aliases replace standard tools with modern alternatives:

| Original | Replacement | Features |
|----------|-------------|----------|
| `cat` | `bat` | Syntax highlighting, git integration |
| `diff` | `delta` | Syntax highlighting, side-by-side view |
| `ls` | `eza` | Icons, git status, better formatting |
| `cd` | `zoxide` | Learns frequently visited directories |

**Source:** `aliases:69-70`

---

### Linux-Only Commands

These commands are only available on Linux systems.

#### open

```bash
open file.pdf           # Open with default application
open https://example.com  # Open URL in browser
```

Uses `xdg-open` under the hood.

**Source:** `functions:234-236`

#### iso2sd

Write ISO images to SD cards or USB drives:

```bash
iso2sd                  # Show usage and available devices
iso2sd ~/Downloads/ubuntu.iso /dev/sda
```

Automatically ejects the device when complete.

**Source:** `functions:238-248`

#### format-drive

Format a drive as exFAT (cross-platform compatible):

```bash
format-drive            # Show usage and available drives
format-drive /dev/sda "My Drive"
```

**Warning:** This completely erases the drive. Prompts for confirmation.

**Source:** `functions:250-276`

---

## Configuration Files

| File | Purpose |
|------|---------|
| `~/.zshrc` | Entry point, sources all modules |
| `~/.config/zsh/shell` | History, completion, vi-mode, key bindings |
| `~/.config/zsh/envs` | Environment variables, PATH |
| `~/.config/zsh/aliases` | Command aliases |
| `~/.config/zsh/functions` | Shell functions |
| `~/.config/zsh/plugins` | Zsh plugin loading |
| `~/.config/zsh/op-secrets` | 1Password integration |
| `~/.config/zsh/init` | Tool initialization (starship, zoxide, fzf, etc.) |

---

## Additional Config Files

These files are sourced if they exist:

| File | Purpose |
|------|---------|
| `~/.envs` | Machine-specific environment variables |
| `~/.local/bin/env` | Local binary environment |
| `~/.commands_manager` | Custom command management |
