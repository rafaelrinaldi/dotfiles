[author]: https://rinaldi.io
[joel]: https://joelglovier.com
[chezmoi]: https://chezmoi.io

# dotfiles

[<img src="dotfiles.png" width="70">][joel]

## Prerequisites

- Homebrew
- Bitwarden account (for secrets)

## Fresh Installation

```bash
sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply rafaelrinaldi/dotfiles
```

This will prompt for:

- Machine profile (personal or work)
- Bitwarden vault unlock (enter your master password)
- SSH key passphrase (if applicable)

You can also set the profile via environment variable to skip the prompt:

```bash
export CHEZMOI_MACHINE_PROFILE=work
```

## Syncing with Latest

```bash
# Unlock Bitwarden
export BW_SESSION=$(bw unlock --raw)

# Update dotfiles
chezmoi update
```

If you see a config file warning, run `chezmoi init` first.

## Git/GitHub Authentication

This setup automatically switches between work and personal GitHub accounts based on your working directory:

- **`~/work/`** → Uses work email and GitHub user
- **`~/dev/`** → Uses personal email and GitHub user

### Multiple GitHub Accounts

To authenticate multiple GitHub accounts with the `gh` CLI:

```bash
# Authenticate your accounts
gh auth login --hostname github.com --git-protocol ssh --web

# Switch between accounts when needed
gh auth switch
```

The directory-based Git config handles email and user switching automatically. The `gh` CLI can manage multiple authenticated accounts and switch between them as needed.

## License

MIT © [Rafael Rinaldi][author]
