#!/bin/bash
manage=$(awk NR==1 node_list)
scp -o StrictHostKeyChecking=no /home/chuang/.ssh/id_rsa root@$manage:/root/.ssh
scp -o StrictHostKeyChecking=no conf.yaml root@$manage:/root/conf.yaml