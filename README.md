# VPN Server Manager

This project managed to help easily setup OpenVPN-Server with ability of creating and deleting ovpn users.

## How to use:

All commands which you will need to work with server manager are stored in _/server/server_scripts_ directory.  
First and foremost, execute script _SetupVPNServer_ with **<ip_address>** of your server.
This script installs all necessary packages and ovpn server with generating .ovpn user file.

> SetupVPNServer script usage example:  
>  
> `./SetupVPNServer <ip_address>`

# !NOTE!
If you accidentally deleted \"hosts\" file, you'll need to create new one and write **\"ansible_hosts=0.0.0.0\"** to it, 
otherwise _SetupVPNServer_ script won't work properly.

## Adding and deleting users

After executing _SetupVPNServer_ you allowed to create new users using _addVpnUser_ and delete them executing
_deleteVPNUser_ scripts. Each of them requires only one parameter which is _name_ of user, but before executing it you'll need
to set variable **openvpn_master_password** in **/server/global_vars/all/global.yml** file for generating easy-rsa keys. 
When you execute _addVpnUser_ script on your pc would be downloaded users _.ovpn_ file in '/ovpn_users' directory.

>_addVpnUser_ and _deleteVpnUser_ scripts usage example:
>  
>`./addVpnUser <name>`  
>`./deleteVpnUser <name>`
