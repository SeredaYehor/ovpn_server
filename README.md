# VPN Server Manager

These project managed to help easily setup VPN server with ability of creating and deleting ovpn users.

## How to use:

All commands which you will need to work with server manager are storaging in /server/server_scripts directory.
First and foremost, execute script SetupVPNServer with <ip_address> of your server. This script installs all
necessary packages and installs ovpn server with generating .ovpn user file. 

Example of SetupVPNServer:
./SetupVPNServer <ip_address>

# !NOTE!
If you acidentally deleted file hosts, you'll need to create new one add print ansible_hosts=0.0.0.0 string, 
otherwise SetupVPNServer script won't work porperly.

## Adding and deleting users

After executing SetupVPNServer you allowed to create new users using addVpnUser and delete them executing
deleteVpnUser. Each of them get only one parametr which is <name> of user, but before executing you'll need
to set variable openvpn_master_password in /server/global_vars/all/ directory for generating easy-rsa keys.
When you execute addVpnUser script on your pc would be downloaded users .ovpn file in '/ovpn_users' path.

Example of addVpnUser adn deleteVpnUser
./addVpnUser <name>
./deleteVpnUser <name>




