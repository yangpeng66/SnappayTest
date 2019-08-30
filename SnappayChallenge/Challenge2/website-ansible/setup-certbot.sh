tput rev
echo "setting up certificates with Certbot, via an Ansible Playbook"
tput sgr0
ansible-playbook -i certbot_inventory setup-certbot.yml --extra-vars "@config.json" --ask-become-pass


