# VPN Server Manager V.2

This repository aimed to create infrastructure based on OpenVPN-Server including monitor server.

## How to setup infrastructure

To manage setup of OpenVPN-server with CoreServer which is using to create student workstations
and linking it with MonitoringServer you'll need to configure hosts file and set there <host_ip> for
each server and then set variables in each role for managing working of scripts.

>Example of hosts file:
>
>
>`VPNSERVER ansible_port=22 ansible_host=1.1.1.1`
>
>`MONITORSERVER ansible_port=22 ansible_host=2.2.2.2`
>
>`CORESERVER ansbile_port=22 ansible_host=3.3.3.3`


## Generating ssh keys

Before executing all scripts you should generate ssh keys for remote user, which will execute all command on servers.
To create these keys you need to execute **setupBot** script with specifying remote_user for connecting to server, 
array of your future servers ip and press enter every time when scripts asks for input.

>Example of executing setupBot script
>
>`./setupBot my_user 1.1.1.1 2.2.2.2 3.3.3.3`

## Setup of OpenVPN-server

As mentioned below, first and foremost, change **<host_ip>** for VPNSERVER on ip of your host. After
that change **<vpn_password>** value of openvpn_master_password variable in **variables.yml**
file. Then you can execute setupVpnServer script.

>Example of vars file:
>
>`openvpn_master_password: 75831246`

>Example of executing setupVpnServer script:
>
>`./setupVpnServer`

## Setup CoreServer

Before using _SetupClient_ script you should have server.ovpn file from your OpenVPN-server, which could be created
using _manageUser_ script with argument **<--add>** or **<--del>** and name of user. For creating user with specified
name, configure **./roles/UserManager/vars/main.yml** file by setting up correct **<openvpn_master_password>**. 
And the last, change port of cadvisor service in file **variables.yml**. After all tasks are 
succesfully done, you may start _SetupClient_ script.


>Example of vars file:
>
>`cadvisor_port: 8080`

>Example of executing manageUser script:
>
>`./manageUser --add Tom`
>`or`
>`./manageUser --del Tom`

>Example of executing SetupCoreServer script:
>
>`./SetupCoreServer`

## Setup MonitoringServer (Optional)

The last server, which you'll need if you want to monitor all containers on CoreServer is Monitoring server. 
To correctly configure it you should change **<core_server_host_ip>** to ip of your **CoreServer**, including 
exposed port of cadvisor on the server, sets **<nginx_login>** and **<nginx_password>** for accessing to prometheus 
on **<ip_of_monitoring_server>**:80 link and changing **<grafana_password>** on any desired value. That's everything 
that you must to do before executing _SetupMonitor_. 

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

## Setup ELK stack (Optional)

If you want to recieve logs from containers and your CoreServer and visualise it, you'll need
ELK stack which consist of filebeat, logstash, elasticsearch and kibana servers. For working ELK needs to setup
CoreServer with **filebeat_enabled** var setted with value **"true"**, which locates in _./variables.yml_.
After that you can easily connect your server to ELK. Secondary, you should specify in _hosts_ file your additional servers
by replacing **<host_ip>** for KIBANA, ELASTIC and LOGSTASH. Then, you'll need to set values of vars in **ELK_configuration** file,
where **network* is a address of your network(e.g. vpn), ip of elastic and logstash servers. After that you've fully managed 
configuration of ELK stack for your CoreServer, so that you can setup it by executing _SetupLogService_ script with no parameters.  

>Example of executing SetupLogService script:
>
>`./SetupLogService`

