# nextcloud_ansible
Deploying a VM from scratch in Proxmox, installing nextcloud aio
In my case, the external name of nextcloud will be next.YOUR_DOMAIN_NAME.
Hostname - cap-next.
Internal ip address - 192.168.1.180.
Nextcloud local installation requirements are described here - https://github.com/nextcloud/all-in-one/blob/main/local-instance.md#1-the-recommended-way

1. You must first add A records on the dns server:

cap-next.in A 191.168.1.180

next A external_ip_address

2. You also need to add and enable the configuration on the reverse proxy nginx server, configuration example - "next" file.

To do this, add a link to the /etc/apt/sources.list file:

`deb http://ppa.launchpad.net/ansible/ansible/ubuntu main main`

The following is the command:

`apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367`

`apt update`

`apt install ansible`

`apt install pip`

`apt install tree`

`apt install unzip`

`pip install proxmoxer`

`pip install requests`

`ansible-galaxy collection install community.general`


3. Create a directory and role for our project:

`mkdir ansible && cd ansible`

`ansible-galaxy init install_nextcloud_server`

4. Download and unpack the archive from the current repository:
`wget https://github.com/stavropolsky/install_nextcloud_server/archive/refs/heads/master.zip`

`unzip /root/ansible/master.zip -d /root/ansible/install_nextcloud_server/tmp && cd /root/ansible/install_nextcloud_server/tmp/install_nextcloud_server-master`

6. Arrange files and folders in their places and delete temporary files and folders:
`mkdir -p /root/ansible/install_nextcloud_server/templates/pve_create_vm`

`cp pve_create_vm.yml ../../ && cp files/. ../../files/ -r && cp templates/pve_create_vm/preseed.cfg.j2 ../../templates/pve_create_vm/`

`rm -r /root/ansible/install_nextcloud_server/tmp/ /root/ansible/master.zip`
8.



