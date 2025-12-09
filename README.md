[author]: https://rinaldi.io
[joel]: https://joelglovier.com
[chezmoi]: https://chezmoi.io

# dotfiles

[<img src="dotfiles.png" width="70">][joel]

Personal dotfiles managed with [chezmoi].

## Prerequisites

- macOS
- Bitwarden account with a `chezmoi` item containing secrets

## Fresh Installation

Run the bootstrap script on a fresh machine:

```bash
curl -fsLS https://rinaldi.io/dotfiles -o /tmp/install.sh && bash /tmp/install.sh
```

This will:

1. Install Homebrew
2. Install chezmoi
3. Install asdf + Node.js
4. Install Bitwarden CLI
5. Prompt for Bitwarden login and vault unlock
6. Prompt for machine profile (**personal** or **work**)
7. Apply all dotfiles

After completion, restart your terminal to switch to Fish shell.

## Syncing with Latest

Pull the latest changes from the remote and apply them:

```bash
# Unlock Bitwarden (if session expired)
export BW_SESSION=$(bw unlock --raw)

# Pull and apply updates
chezmoi update
```

Or just pull without applying:

```bash
chezmoi git pull
chezmoi diff  # Review changes
chezmoi apply
```

## Git/GitHub Multi-Account Setup

This setup **automatically** uses the correct GitHub account based on repo ownership:

| Repo Owner        | Account Used |
| ----------------- | ------------ |
| `rafaelrinaldi/*` | Personal     |
| Everything else   | Work         |

No manual switching required. Push/pull just works.

### How It Works

A custom credential helper (`~/.config/git/git-credential-resolver`) inspects the repo URL and returns the appropriate token.

Additionally, directory-based gitconfig sets the correct email:

- **`~/work/`** → Work email
- **`~/dev/`** → Personal email
- **`~/.local/share/chezmoi/`** → Personal email

## License

MIT © [Rafael Rinaldi][author]
