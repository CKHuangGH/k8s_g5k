#!/bin/bash
manage=$(awk NR==1 node_list)
rm -rf /home/chuang/.ssh/known_hosts
scp -o StrictHostKeyChecking=no /home/chuang/.ssh/id_rsa root@$manage:/root/.ssh
scp -o StrictHostKeyChecking=no conf.yaml root@$manage:/root/conf.yaml