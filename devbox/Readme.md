## Devbox

If I had a dollar for everytime I wanted to debug something on cloud in
a "real" environment, I wouldn't have much money but I'd be significantly
happier. Hence, these scripts for creating a devbox quickly, anywhere, anytime.

### Goals

**Basic configuration**

- [  ] should support localhost as well as remote IP
    - static inventory file for now
- [  ] configure hostname on an Ubuntu 16.04 box: ric03uec
- [  ] disable password ssh, only key-based login allowed
- [  ] create user "plato" with passwordless root access with home directory
- [  ] create public-private keypair for plato
- [  ] install htop
- [  ] install git
- [  ] install tmux
- [  ] configure tmux
    - tmuxrc file
    - tmux resurrect plugin
    - shortcuts and colors
- [  ] install zsh
- [  ] configure zsh
    - theme
    - shortcuts
- [  ] install nvim
- [  ] configure nvim
    - install all plugins
- [  ] install docker
- [  ] configure docker
    - disable http listener
    - configure data directory

**Addons**
- [  ] install nginx
- [  ] install certbot
- [  ] generate certs for plato.ric03uec.com
