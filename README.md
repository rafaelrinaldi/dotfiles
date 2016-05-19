[author]: http://rinaldi.io
[joel]: http://joelglovier.com
[rcm]: https://github.com/thoughtbot/rcm

# dotfiles

[<img src="dotfiles.png" width="70">][joel]

## Requirements

You'll need [rcm][rcm]:

```fish
$ brew tap thoughtbot/formulae; brew install rcm
```

## Install

```fish
$ git clone git@github.com:rafaelrinaldi/dotfiles.git $HOME/dotfiles
$ env RCRC=$HOME/dotfiles/rcrc rcup
```

Keep a `~/dotfiles` folder just for convenience.

## Update

```fish
$ cd $HOME/dotfiles; git pull
$ rcup -d $HOME/dotfiles
```

## License

MIT © [Rafael Rinaldi][author]
