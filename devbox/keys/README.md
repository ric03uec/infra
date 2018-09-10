## Keys
- **DO NOT COMMIT ANY SENSITIVE INFORMATION IN THIS FOLDER**
- only `.md` files should be added here. These can provide guidelines on naming
  conventions or other information to considered before copying keys in this
  folder

### Public Keys
- all files with extension `.public` will be added to the `authorized_keys`
  file of the remote machine

### Private Keys
- The only files OK to be stored here are templates that can be used to easily
  create keys by replacing some fields.
    - the extension `*.template` should be used for those
- if running commands manually
    - store any temporary keys here
    - run ansible playbooks to execute remote commands using the keys
    - remove the keys
- if running command via automation scripts
    - copy keys in this folder in some pre-processing step
    - run ansible playbooks to execute remote commands using the keys
    - remove the keys as part of post-processing step

