tput rev
echo "building server with Ansible Playbook"
tput sgr0
ansible-playbook -i local_inventory pn-server.yml --extra-vars "@config.json" --ask-become-pass -v


