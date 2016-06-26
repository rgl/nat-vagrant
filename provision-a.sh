#!/bin/bash
set -eux

config_domain=$(hostname --domain)
config_gw=10.10.10.254

# configure the system resolver to use the gw DNS server.
echo "nameserver $config_gw" >/etc/resolv.conf
echo "dns-nameservers $config_gw" >>/etc/network/interfaces

apt-get install -y --no-install-recommends vim
cat >/etc/vim/vimrc.local <<'EOF'
syntax on
set background=dark
set esckeys
set ruler
set laststatus=2
set nobackup
autocmd BufNewFile,BufRead Vagrantfile set ft=ruby
EOF

# dump the routing table.
ip route
