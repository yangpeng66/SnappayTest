## Preparing the server
Besides running the following commands on the server the install should work:

record the ip address of your new server
in this example:

IP is say 10.111.11.111
Shells are :

%> is your local shell
$> server's shell

locally add info to your ~/.ssh/config file

    Host xxxx.server

                Hostname 10.111.11.111

                User username

                Port 22

                UserKnownHostsFile /dev/null

                StrictHostKeyChecking no

                PasswordAuthentication no

                IdentityFile "/Users/<<your username here>>/.ssh/id_rsa"

                IdentitiesOnly yes

                ForwardAgent yes

                LogLevel FATAL



login as root
( from your local ssh client, like CYGWIN )

    %> ssh root@10.111.11.111

    enter the following commands

    $> yum update

    $> groupadd dev

    $> useradd snappay

    $> passwd snappay

    $> usermod -a -G wheel snappay

    $> usermod -a -G dev snappay

    $> su snappay

    $> cd && mkdir .ssh && chmod 700 .ssh && cd .ssh

    $> vi authorized_keys

    add your public ssh key here ( typically ~/.ssh/id_rsa.pub

    $> chmod 600 authorized_keys 

    $> exit 

    $> exit 


now you should be able to login as snappayuser to test

%> ssh server

%> ansible-playbook -i local_inventory pn-server.yml --ask-become-pass -vvvv