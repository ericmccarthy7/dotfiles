# dotfiles

## requirements

- neovim
- ripgrep
- fzf
- eza
- uv
- nodejs
- pnpm
- cargo

`~/.config/chezmoi/chezmoi.toml`

```
[data]
	email = "my_personal_email@gmail.com"
	work = false
```

## todo:

- update .langservers.sh once in a while with latest lua-language-server

## python weird steps

```
sudo apt install python3-full build-essential libssl-dev
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
curl https://pyenv.run | bash
pyenv install 3.12.4
```
