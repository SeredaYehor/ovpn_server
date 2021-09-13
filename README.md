# VPN Server Manager

This project managed to help easily setup OpenVPN-Server with ability of creating and deleting ovpn users.

## How to use:

###1. Setup VPN server: ./setupServer <ip_address>
###2. Creating of VPN user: ./addUser <name>
###3. Deleting existing VPN user: ./deleteUser <name>
###4. Loading VPN configuration file from usb to thin client: ./LoadVpnFile

All commands which you will need to work with server manager are stored in _/server/server_scripts_ directory.  
First and foremost, execute script _setupServer_ with **<ip_address>** of your server.
This script installs all necessary packages and ovpn server with generating .ovpn user file.

> setupServer script usage example:  
>  
> `./setupServer <ip_address>`

# !NOTE!
If you accidentally deleted \"hosts\" file, you'll need to create new one and write **\"ansible_hosts=0.0.0.0\"** to it, 
otherwise _SetupVPNServer_ script won't work properly.

## Adding and deleting users

After executing _setupServer_ you allowed to create new users using _addUser_ and delete them executing
_deleteUser_ scripts. Each of them requires only one parameter which is _name_ of user, but before executing it you'll need
to set variable **openvpn_master_password** in **/server/global_vars/all/global.yml** file for generating easy-rsa keys. 
When you execute _addVpnUser_ script on your pc would be downloaded users _.ovpn_ file in '/ovpn_users' directory.

>_addUser_ and _deleteUser_ scripts usage example:
>  
>`./addUser <name>`  
>`./deleteUser <name>`

  
## Loading VPN users into thin client
  
Last necessary script for working of local VPN network is _loadVpnFile_, which allows you to load .ovpn file to thin client and
restart them with working openvpn. Everything what you'll need is input into client usb storage with .ovpn user file.

>_loadVpnFile_ usage example:
>
>`./LoadVpnFile`
 
