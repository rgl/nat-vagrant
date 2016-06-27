This is a [Vagrant](https://www.vagrantup.com/) Environment for a simple IP [NAT](https://en.wikipedia.org/wiki/Network_address_translation) gateway using [iptables](https://en.wikipedia.org/wiki/Iptables).

![](network.png)

# Usage

Run `vagrant up` to configure the `gw.example.com` gateway that redirects requests from `a11.example.com` and `a12.example.com` to the internet.

To watch the traffic, run:

    vagrant ssh gw
    tcpdump -n -i eth1 not port ssh 

To generate some traffic, run:

    vagrant ssh a11
    ping ruilopes.com

To test redirecting a port from internet to a specific host inside the internal network (i.e. DNAT), run, on the host:

```sh
http 10.10.11.254:8001       # if you have httpie
wget -qO- 10.10.11.254:8001
```
