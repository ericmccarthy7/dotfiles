#!/bin/bash

brew install lua-language-server
rustup component add rust-analyzer
pnpm i -g pyright typescript typescript-language-server @astrojs/language-server
pnpm i -g @vue/language-server yaml-language-server vscode-langservers-extracted
pnpm i -g bash-language-server @angular/language-server
