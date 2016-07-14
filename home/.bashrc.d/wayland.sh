# Update PATH to include custom directories. This is a workaround for
# gnome-wayland, which does not load /etc/profile

export PATH=/usr/local/sbin:/usr/sbin:/sbin:"$PATH"

if [ -n "$HOME" ] && [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi
