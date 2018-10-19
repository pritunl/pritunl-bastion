#!/bin/bash

echo -e "$BASTION_TRUSTED" > /ssh/trusted
echo -e "$BASTION_HOST_KEY" > /ssh/ssh_host_rsa_key
echo -e "$BASTION_HOST_PUB_KEY" > /ssh/ssh_host_rsa_key.pub
chmod 0600 /ssh/ssh_host_rsa_key

tee /ssh/sshd_config << EOF
Port 9722
AddressFamily any
ListenAddress 0.0.0.0
ListenAddress ::
HostKey /ssh/ssh_host_rsa_key
HostCertificate /ssh_mount/ssh_host_rsa_key-cert.pub
PermitRootLogin no
PasswordAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
DenyUsers root bin daemon adm lp sync shutdown halt mail news uucp operator man postmaster cron ftp sshd at squid xfs games postgres cyrus vpopmail ntp smmsp guest nobody

Match User bastion
	AllowAgentForwarding no
	AllowTcpForwarding yes
	PermitOpen *:22
	GatewayPorts no
	X11Forwarding no
	PermitTunnel no
	ForceCommand echo 'Pritunl Zero Bastion Host'
	TrustedUserCAKeys /ssh/trusted
	AuthorizedPrincipalsFile /ssh/principals
Match all
EOF

/usr/sbin/sshd -D -f /ssh/sshd_config
