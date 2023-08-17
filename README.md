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

5. Arrange files and folders in their places and delete temporary files and folders:
   
`mkdir -p /root/ansible/install_nextcloud_server/templates/pve_create_vm`

`cp pve_create_vm.yml ../../ && cp files/. ../../files/ -r && cp templates/pve_create_vm/preseed.cfg.j2 ../../templates/pve_create_vm/ && cp -r group_vars/ ../../`

`rm -r /root/ansible/install_nextcloud_server/tmp/ /root/ansible/master.zip`

6. Editing files:
   
   /root/ansible/install_nextcloud_server/group_vars/all:
   
pve_api_user: "root@pam"
pve_api_password: "your_root_password" - you must specify the root@pam password
domain: "your_domain_name" - you must specify an existing domain, for example - yourcompany.com
vmid: 180 - vmid any integer
node: "pve" - specify your existing node name
pve_guest: "cap-next" - enter the name of your future server

/root/ansible/install_nextcloud_server/files/compose.yml

YOUR_REVERSE_PROXY_NGINX_IP_ADDRESS - replace with the real ip address of your reverse proxy nginx server

/root/ansible/install_nextcloud_server/files/.env

YOUR_DATABASE_PASSWORD - your future database password

NC_DOMAIN - external dns name nextlcoud, e.g. - next.yourcompany.com

NEXTCLOUD_PASSWORD - future admin user password in nextcloud

ONLYOFFICE_SECRET - any password

REDIS_PASSWORD - any password

SIGNALING_SECRET - any password

TALK_INTERNAL_SECRET - any password

TURN_SECRET - any password

TALK_INTERNAL_SECRET - any password

/root/ansible/install_nextcloud_server/templates/pve_create_vm/preseed.cfg.j2

d-i netcfg/choose_interface select ens18 - any desired network interface name

d-i netcfg/get_hostname string cap-next - the name of the VM to be created

d-i netcfg/get_domain string YOUR_DOMAIN_NAME - domain name such as yourcompanyname.com

d-i netcfg/hostname string cap-next - hostname VM

d-i pkgsel/include string openssh-server curl ca-certificates docker-compose - installing packages openssh-server curl ca-certificates docker-compose

In the # Post commands section, instead of YOUR PUBLIC SSH KEY PROXMOX, you must specify a valid public key of your proxmox server so that it can connect to the guest VM you are creating via ssh

7. Launching playbook from /root/ansible/install_nextcloud_server directory:

   `ansible-playbook pve_create_vm.yml -e "pve_node=pve" -e "ansible_ssh_common_args='-o StrictHostKeyChecking=no'"`
