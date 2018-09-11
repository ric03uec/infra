## Devbox

If I had a dollar for everytime I wanted to debug something on cloud in
a "real" environment, I wouldn't have too much money but I'd be significantly
happier.
Hence, these scripts for creating a devbox quickly, anywhere, anytime.

### Run
- copy `hosts.template` to `hosts` and update the IP address of host to be
  bootstrapped

- use following command to apply the changes

```
$ docker run --rm -v $(pwd):/ansible ric03uec/cansible:master -vv -i /ansible/hosts /ansible/bootstrap_system.yml
```

```
## for debug(human-readable) logs
$ docker run --rm -v $(pwd):/ansible -e ANSIBLE_STDOUT_CALLBACK=debug ric03uec/cansible:master -vv -i /ansible/hosts /ansible/bootstrap_system.yml
```

### Goals

**System configuration**

- [ ] should support localhost as well as remote IP
    - static inventory file for now
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
- [  ] copy the remote public key in local keychain
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
- [  ] install nginx // required to serve traffic from the box
- [  ] install certbot
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

### Building
- bundle everything up in a Makefile. It should be possible to run just the
  system config, basic packages, addons scripts.
    - I'd want to install some packages for testing later which should not
      really affect the base system configuration
