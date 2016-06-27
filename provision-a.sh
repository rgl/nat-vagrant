#!/bin/bash
set -eux

config_fqdn=$(hostname --fqdn)
config_fqdn_ip=$(hostname -I | awk '{print $2}')
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

apt-get install -y tcpdump

# have a simple web page with the name and ip of this machine
# available at port 80. we'll use this to demo the mapping
# of an internet port to this internal machine.
apt-get install -y --no-install-recommends nginx
cat<<EOF>/var/www/html/index.html
<pre>
http://$config_fqdn:80
http://$config_fqdn_ip:80
</pre>
EOF

# dump the routing table.
ip route
