# User Management

An Ansible role manage linux users. It can create and setup the linux users on Ubuntu or Redhat.

## Requirements

* Users Variable is required to create users.

## Role Variables

users is a dictionary with user inputs.


No. | Variable Name | Description
---|---|---
1   | username      | Name of the user.
2   | group         | Name of the user group.
3   | groups        | List of groups, user need to be added.
4   | shell         | Shell for the user. Default `/sbin/nologin`.
5   | password      | Hash Password of the user. Default `no password` set.
6   | create_home   | Set to `no` if home directory not need for the user. Default is `yes`.
7   | system        | Set to `yes` if its a system user. Default is `no`.
8   | key           | SSH Key of the user.
9   | key_options   | A string of ssh key options to be prepended to the key in the authorized_keys file. 
10  | home          | Set home directory if its other than `/home/username/`.
11  | bashrc        | Content of bashrc file. User multile yaml format.
12  | bash_profile  | Content of bash_profile file. User multile yaml format.

## Dependencies

* Ansible

### Test Dependencies

* Python
* Molecule
* Docker
* Ruby

# Test Setup

Molecule is a testing framework for Ansible Role and we are using Docker to converge, verify and destory. 

**Setup Commands**

**Ubuntu**

```
apt-get install -y ansible docker-ce python pip ruby-full

pip install molecule docker

gem install rubocop
```

**Redhat / Centos**

```
yum install -y ansible docker-ce python pip ruby

pip install molecule docker

gem install rubocop

```

## How to generate password

**Ubuntu**

Install `whois` package

```
mkpasswd --method=SHA-512
```
**RedHat** 

Use Python

```
python -c 'import crypt,getpass; print(crypt.crypt(getpass.getpass(), crypt.mksalt(crypt.METHOD_SHA512)))'
```

# Running Test

You can make necessary changes to [playbook](molecule/default/playbook.yml) and [test file](molecule/default/tests/test_default.rb) and run test using below commands to get test output.

```
$ sudo molecule converge

$ sudo molecule verify
```

Example Playbook
----------------

You can run the playbook by the using playbook define inside `molecule/default/playbook.yml` or create adhoc-playbook `run-user-management.yml` as provided below and run by using command provided below.

```
---
- name: Converge
  hosts: all
  become: yes
  become_user: root
  pre_tasks:
    - name: Creating Standard Groups
      group:
        name: "{{ item }}"
        state: present
      loop:
        - sysadmin
        - webadmin
  vars:
    users:
      - username: tom
        group: tom
        groups:
          - sysadmin
        shell: '/bin/bash'
        ssh_key: ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9Tjom/BWDSUGPl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XAt3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88XypNDvjYNby6vw/Pb0rwert/EnmZ+AW4OZPnTPI89ZPmVMLuayrD2cE86Z/il8b+gw3r3+1nKatmIkjn2so1d01QraTlMqVSsbxNrRFi9wrf+M7Q== tom@mylaptop.local
        bashrc: |+
            #!/usr/bin/env bash

            # Path to the bash it configuration
            export BASH_IT="/home/giggio/.bash_it"

            # Lock and Load a custom theme file
            # location /.bash_it/themes/
            export BASH_IT_THEME='powerline-multiline'

            # (Advanced): Change this to the name of your remote repo if you
            # cloned bash-it with a remote other than origin such as `bash-it`.
            # export BASH_IT_REMOTE='bash-it'

            # Your place for hosting Git repos. I use this for private repos.
            export GIT_HOSTING='git@git.domain.com'

      - username: mike
        group: mike
        groups:
          - webadmin
        ssh_key: ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAklOUpkDHrfHY17SbrmTIpNLTGK9Tjom/BWDSUGPl+nafzlHDTYW7hdI4yZ5ew18JH4JW9jbhUFrviQzM7xlELEVf4h9lFX5QVkbPppSwg0cda3Pbv7kOdJ/MTyBlWXFCR+HAo3FXRitBqxiX1nKhXpHAZsMciLq8V6RjsNAQwdsdMFvSlVK/7XAt3FaoJoAsncM1Q9x5+3V0Ww68/eIFmb1zuUFljQJKprrX88XypNDvjYNby6vw/Pb0rwert/EnmZ+AW4OZPnTPI89ZPmVMLuayrD2cE86Z/il8b+gw3r3+1nKatmIkjn2so1d01QraTlMqVSsbxNrRFi9wrf+M7Q== mike@mylaptop.local
        bash_profile: |+
            # aliases
            alias cd..="cd .."
            alias l="ls -al"
            alias lp="ls -p"
            alias h=history

            # the "kp" alias ("que pasa"), in honor of tony p.
            alias kp="ps aux"

  roles:
    - user-management
```

Run the playbook using below command

```
ansible-playbook -i inventoryfile run-user-management.yml
```

Run against specific host

```
ansible-playbook -i inventoryfile run-user-management.yml --limit {HOSTLIST}
```

Author Information
------------------

You can always open Pull request for contribution to the project or email to **mohsinzaheer25@hotmail.com**
