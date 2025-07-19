[author]: https://rinaldi.io
[joel]: https://joelglovier.com
[chezmoi]: https://chezmoi.io
[bw]: https://bitwarden.com/help/cli

# dotfiles

[<img src="dotfiles.png" width="70">][joel]

## Requirements

You'll need [chezmoi][chezmoi] and [bw][bw] available in `$PATH`:

```sh
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install `asdf` (for Node.js), `chezmoi`
brew install asdf chezmoi

# Install the latest available Node.js version via `asdf`
asdf plugin add nodejs
asdf install

asdf install nodejs latest
asdf set nodejs latest --home

# Install `bw` via npm
npm i -g @bitwarden/cli
```

## Setup

With all the required software installed, you now must auth then bootstrap

```sh
bw login
export BW_SESSION=$(bw unlock --raw)
chezmoi init rafaelrinaldi/dotfiles
chezmoi apply
```

## License

MIT © [Rafael Rinaldi][author]
