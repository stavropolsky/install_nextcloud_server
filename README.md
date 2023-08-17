# nextcloud_ansible
Deploying a VM from scratch in Proxmox, installing nextcloud aio
In my case, the external name of nextcloud will be next.YOUR_DOMAIN_NAME.
Hostname - cap-next.
Internal ip address - 192.168.1.180.
Nextcloud local installation requirements are described here - https://github.com/nextcloud/all-in-one/blob/main/local-instance.md#1-the-recommended-way

You must first add A records on the dns server:

cap-next.in A 191.168.1.180

next A external_ip_address

You also need to add and enable the configuration on the reverse proxy nginx server, configuration example - next file.
