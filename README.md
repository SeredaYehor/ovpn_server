# VPN Server Manager V.2

This repository aimed to create infrastructure based on OpenVPN-Server including monitor server

## How to setup infrastructure

To manage setup of OpenVPN-server with CoreServer which is using to create student workstations
and linking it with MonitoringServer you'll need to configure hosts file and set there <host_ip> for
each server and then set variables in each role for managing working of scripts.

>Example of hosts file:
>
>
>`VPNSERVER ansible_port=22 ansible_host=1.1.1.1 ansible_connection=ssh ansible_ssh_private_key_file=id_rsa`
>
>`MONITORSERVER ansible_port=22 ansible_host=2.2.2.2 ansible_connection=ssh ansible_ssh_private_key_file=id_rsa`
>
>`CORESERVER ansbile_port=22 ansible_host=3.3.3.3 ansible_connection=ssh ansible_ssh_private_key_file=id_rsa`

## Setup of OpenVPN-server

As mentioned below, first and foremost, change **<host_ip>** for VPNSERVER on ip of your host. After
that change **<vpn_password>** value of openvpn_master_password variable in **./roles/SetupVPN/vars/main.yml**
file. Then you can execute setupVpnServer script.

>Example of vars file:
>
>`openvpn_master_password: 75831246`

>Example of executing setupVpnServer script:
>
>`./setupVpnServer`

# !NOTE!
If you accidentally deleted \"hosts\" file, you'll need to create new one and write **\"ansible_hosts=0.0.0.0\"** 
to it,  otherwise _SetupVPNServer_ script won't work properly.


## Setup CoreServer

Before using _SetupClient_ script you should have .ovpn file from your OpenVPN-server, which could be created
using _manageUser_ script. For creating user with specified name, configure **./roles/UserManager/vars/main.yml** file by
setting up correct openvpn_master_password, specifying **<password>**, setting **user_mode** as **add** and naming of
your VPN-server user **<user_name>**. Then, when .ovpn file will be downloaded, copy it to **./roles/CoreServer/files**
directory where scripts could find it. Copying to another directories are not permitted, so that scripts won't work.
And the last, change port of cadvisor service in file **./roles/CoreServer/vars/main.yml**. After all tasks are succesfully 
done, you may start _SetupClient_ script.

>Example of vars file:
>
>`cadvisor_port: 8080`

>Example of executing SetupClient script:
>
>`./SetupClient`

## Setup MonitoringServer

The last server, which you'll need to setup is Monitoring server. To correctly configure it you should change
**<core_server_host_ip>** to ip of your **CoreServer**, including exposed port of cadvisor on the server, sets 
**<nginx_login>** and **<nginx_password>** for accessing to prometheus on **<ip_of_monitoring_server>**:80 link 
and changing **<grafana_password>** on any desired value. That's everything that you must to do before executing 
_SetupMonitor_. 

>Example of vars file:
>
>`new_grafana_passwd: secr3t`
>
>`cadvisor_server_ip: 123.45.67.89`
>`cadvisor_port: 8080`
>
>`nginx_login: user`
>`nginx_passwd: 43124`

>Example of executing SetupMonitor script:
>
>`./SetupMonitor`
