#!/bin/bash

# Receiving data from the user

echo "Enter the name of the network interface (eg enp0s3:):"
read INTERFACE

echo "Enter the IP address:"
read IP_ADDRESS

echo "Enter the subnet mask (eg 255.255.255.0):"
read NETMASK

echo "Enter the gateway IP address:"
read GATEWAY

echo "Enter the list of IP addresses of DNS servers (by comma, for example, 8.8.8.8, 1.1.1.1):"
read DNS_SERVERS

# Backing up the netplan configuration file

sudo cp /etc/netplan/01-netcfg.yaml /etc/netplan/01-netcfg.yaml.bak

# Setting up a static IP

echo "network:
  ethernets:
    $INTERFACE:
      dhcp4: no
      addresses:
      - $IP_ADDRESS/$NETMASK
      gateway4: $GATEWAY
      nameservers:
        addresses:
        - $DNS_SERVERS" | sudo tee /etc/netplan/01-netcfg.yaml

# Application of changes

sudo netplan apply

# Перевірка результату

ifconfig $INTERFACE

# 10 second delay

sleep 10

# Restarting the server

sudo reboot

