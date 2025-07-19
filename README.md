[author]: https://rinaldi.io
[joel]: https://joelglovier.com
[chezmoi]: https://chezmoi.io
[bw]: https://bitwarden.com/help/cli
[asdf]: https://asdf-vm.com
[npm]: https://www.npmjs.com

# dotfiles

[<img src="dotfiles.png" width="70">][joel]

## Requirements

- [chezmoi][chezmoi]

## Installation

The `.startup.sh` script will ensure the following are installed:
* Xcode Command Line Tools
* Homebrew
* [Password Manager CLI][bw] (via [asdf][asdf] and [npm][npm])

```sh
# Initialize and run startup script
chezmoi init rafaelrinaldi/dotfiles
cd ~/.local/share/chezmoi && ./.startup.sh

# Authenticate Bitwarden
bw login
export BW_SESSION=$(bw unlock --raw)

# Apply dotfiles
chezmoi apply
```

## License

MIT © [Rafael Rinaldi][author]
