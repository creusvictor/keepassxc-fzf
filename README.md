# keepassxc-fzf

Interactive terminal interface for managing KeePass databases using `keepassxc-cli` and `fzf`.

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

### Install keepassxc-fzf

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
    KPPW    Database password (not recommended)
    KPKF    Path to keyfile
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
- Password input is hidden
- Preview masks passwords with `*****`
- No temporary files with sensitive data
- **Warning**: `KPPW` environment variable is not recommended in shared environments

## Troubleshooting

**keepassxc-cli not found**: Install KeePassXC (`sudo apt install keepassxc`)

**fzf not found**: Install fzf (`sudo apt install fzf`)

**Clipboard not working**: Install xclip (`sudo apt install xclip`) or wl-clipboard for Wayland

**Database won't open**: Verify password, file path, and keyfile path if used

## License

MIT
