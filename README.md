# keepassxc-fzf

Interactive terminal interface for managing KeePass databases using `keepassxc-cli` and `fzf`.

![Demo](assets/demo.gif)

## Features

- Interactive entry search with fuzzy finder (fzf)
- Real-time entry preview (password masked)
- Copy to clipboard with auto-clear:
  - Password (10 seconds)
  - Username, URL, Notes (30 seconds)
- Keyfile support
- Configuration via environment variables
- Multi-platform clipboard support (xclip, wl-copy, pbcopy)

## Requirements

### Required

- `keepassxc-cli` - KeePassXC command-line client
- `fzf` - Command-line fuzzy finder
- `bash` - Unix shell

### Optional (clipboard)

- `xclip` (X11)
- `wl-copy` (Wayland)
- `pbcopy` (macOS)

## Installation

### Quick install (recommended)

```bash
# Install to /usr/local/bin (requires sudo)
curl -fsSL https://raw.githubusercontent.com/creusvictor/keepassxc-fzf/main/install.sh | sudo bash

# Or install to ~/.local/bin (no sudo required)
curl -fsSL https://raw.githubusercontent.com/creusvictor/keepassxc-fzf/main/install.sh | PREFIX=~/.local bash
```

### Dependencies

```bash
# Debian/Ubuntu
sudo apt install keepassxc fzf xclip

# Arch Linux
sudo pacman -S keepassxc fzf xclip

# Fedora
sudo dnf install keepassxc fzf xclip

# macOS
brew install keepassxc fzf
```

### Manual install (from source)

```bash
git clone https://github.com/creusvictor/keepassxc-fzf.git
cd keepassxc-fzf

# Install to /usr/local/bin (requires sudo)
sudo make install

# Or install to ~/.local/bin
make install PREFIX=~/.local
```

### Uninstall

```bash
sudo make uninstall
# Or: make uninstall PREFIX=~/.local
```

## Usage

```
keepassxc-fzf [OPTIONS] [database.kdbx]

Options:
    -h, --help          Show help
    -k, --keyfile FILE  Use keyfile

Environment variables:
    KPDB    Path to KeePass database
    KPKF    Path to keyfile

Precedence (highest to lowest):
    1. CLI arguments (-k, database path)
    2. Environment variables (KPDB, KPKF)

Note: KPKF is only inherited from the environment when the database also
comes from KPDB. If you pass a database path on the CLI, env credentials
are ignored to avoid mixing credentials from different databases.
The master password is always entered interactively and is never read
from the environment.
```

### Examples

```bash
# Basic usage
keepassxc-fzf ~/passwords.kdbx

# With keyfile
keepassxc-fzf -k ~/key.key ~/passwords.kdbx

# Using environment variables
export KPDB="$HOME/passwords.kdbx"
export KPKF="$HOME/key.key"
keepassxc-fzf
```

## Keybindings

| Key | Action |
|-----|--------|
| `Ctrl+P` | Copy password (clears in 10s) |
| `Ctrl+U` | Copy username (clears in 30s) |
| `Ctrl+L` | Copy URL (clears in 30s) |
| `Ctrl+N` | Copy notes (clears in 30s) |
| `Alt+S` | Show password on screen |
| `Enter` | Copy password and exit |
| `ESC` | Exit |

Standard fzf navigation also works (`Ctrl+J`/`Ctrl+K`, arrows, type to search).

## Security

- Clipboard auto-clears after timeout
- Password input is always interactive — never read from environment variables
- Preview masks passwords with `*****`
- Master password is passed to fzf subprocesses via a `chmod 600` temporary file, not via environment variables, so it is not visible in `/proc/<pid>/environ`
- Temporary password file is deleted on exit via a `trap`

## Troubleshooting

**keepassxc-cli not found**: Install KeePassXC (`sudo apt install keepassxc`)

**fzf not found**: Install fzf (`sudo apt install fzf`)

**Clipboard not working**: Install xclip (`sudo apt install xclip`) or wl-clipboard for Wayland

**Database won't open**: Verify password, file path, and keyfile path if used

## License

MIT
