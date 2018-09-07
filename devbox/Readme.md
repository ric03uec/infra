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
- [x] create public-private keypair for plato
- [x] install htop
- [x] install git
- [x] install [git-extras](https://github.com/tj/git-extras/blob/master/Installation.md)
- [x] install tmux
- [  ] configure tmux
    - tmuxrc file
    - tmux resurrect plugin
    - shortcuts and colors
- [  ] configure zsh
    - theme
    - shortcuts

**Basic packages**
- [  ] install nvim
- [  ] configure nvim
    - install all relevant plugins
- [  ] install docker
- [  ] configure docker
    - disable http listener
    - configure data directory

**Addons**
- [  ] install nginx // required to serve traffic from the box
- [  ] install certbot
- [  ] generate certs for plato.ric03uec.com

