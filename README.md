# firewall
Iptables firewall based solution

# Installation 

Copy all file on your machine in /etc/firewall/ and Edit the `firewall.conf` file to set your general settings such as interfaces names and options.

Then edit all file as needed to create your firewall rules, (iptables knowledge required) :
- `blocklists` : used to block large range of IP by country located in `zones` folder
- `default` : set the default firewall policy (DROP ALL by default)
- `masquerade` : for NAT and Masquerading rules 
- `forward` : for allowing forwarded traffic from an interface to an other
- `redirect` : for traffic redirection
- `input` : for incoming traffic
- `output` : for out going traffic

# Usage

Start the firewall :
```
./firewall.sh start
```

Stop the firewall :
```
./firewall.sh stop
```

Restart or reload rules : 
```
./firewall.sh restart
```

# Auto Launch at reboot

As root : 
```
crontab -e 
>>
@reboot /your/path/firewall.sh start
```
