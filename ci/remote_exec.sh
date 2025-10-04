#!/bin/bash
scp -o StrictHostKeyChecking=no -i ~/.ssh/id_ed25519 $1 deployer@$2:/home/deployer/
ssh -i ~/.ssh/id_ed25519 deployer@$2 "bash /home/deployer/deploy_remote.sh /home/deployer/$(basename $1)"

