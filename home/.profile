# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes sbin, which is disabled for non-root users
# by default
PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# The gpg agent is expected to be launched via systemd's user mode (see
# /usr/lib/systemd/user/gpg-agent.{socket,service} and systemd.unit(5)). This
# allows systemd to clean up the agent automatically at logout. However, ssh
# needs to be made aware of where to find the agent via an environment variable.
if [ -n "$(gpgconf --list-options gpg-agent | \
      awk -F: '/^enable-ssh-support:/{ print $10 }')" ]; then
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    export SSH_AUTH_SOCK
fi

# Start sway
[ "$(tty)" = "/dev/tty1" ] && [ ! -e "$HOME/no-sway" ] && exec sway
