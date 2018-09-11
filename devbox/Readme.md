## Devbox

If I had a dollar for everytime I wanted to debug something on cloud in
a "real" environment, I wouldn't have too much money but I'd be slightly
happier.
Hence, these scripts for creating a devbox quickly, anywhere, anytime.

### Run
- copy `hosts.template` to `hosts` and update the IP address of host to be
  bootstrapped

- use following command to apply the changes

```
$ setup.sh remote|desktop
```

### Goals

**System configuration**

- [x] static inventory file for now
- [x] read hostname and other variables from variables file
- [x] configure hostname on an Ubuntu 16.04 box: plato
- [x] install python minimal, needed for ansible to work correctly
- [x] install and rng-tools (haveged?)
- [x] disable password ssh, only key-based login allowed
- [x] install zsh
- [x] create user "plato" with passwordless root access with home directory
    - set shell as zsh
    - update ownership of home directory(and subdirectories)
- [x] create public-private keypair for plato
- [x] install htop
- [x] install git
- [x] install [git-extras](https://github.com/tj/git-extras/blob/master/Installation.md)
- [x] install tmux
- [x] configure zsh
    - theme
    - shortcuts
- [x] configure tmux
    - tmuxrc file
    - tmux tony
    - tmux resurrect plugin
    - shortcuts and colors
- [x] add local public key in new user's authorized keys
- [x] copy local github key to remote
    - this should be the key used for all github related operations

**Basic packages**

- [x] install nvim
- [x] configure nvim
    - install all relevant plugins
- [x] install docker
- [x] configure docker
    - set correct group, run as non root user: https://docs.docker.com/install/linux/linux-postinstall/
    - disable http listener
    - configure data directory

**Addons**

- [x] install nginx // required to serve traffic from the box
- [x] install certbot
- [  ] generate certs for plato.ric03uec.com

**For desktop**

- [  ] install terminator
- [  ] install firefox nightly
- [  ] install chrome
- [  ] install dropbox
- [  ] install spotify
- [  ] install slack, xoom, openoffice

**Misc**

- [  ] show warning if no keys have been added
- [  ] output everything in a file with timestamp for audit
