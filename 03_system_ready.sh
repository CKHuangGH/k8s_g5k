#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
#git clone https://github.com/CKHuangGH/mck8s_vm.git
#git clone https://github.com/CKHuangGH/rntsm.git
scp node_list root@$manage:/root/mck8s_vm/node_list
rm -rf /home/chuang/.ssh/known_hosts

for j in $(cat node_list)
do
ssh -o StrictHostKeyChecking=no root@$j git clone https://github.com/CKHuangGH/mck8s_vm.git
ssh -o StrictHostKeyChecking=no root@$j git clone https://github.com/CKHuangGH/rntsm.git
scp /home/chuang/.ssh/id_rsa root@$j:/root/.ssh
ssh -o StrictHostKeyChecking=no root@$j mv /root/.kube/config /root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j scp -o StrictHostKeyChecking=no /root/.kube/cluster$i root@$manage:/root/.kube
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/01_combineAll.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/02_rntsmvalue.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/03_createmember.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/04_mck8s-2.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/05_joining_test.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/06_deployment.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/createvalue.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/results/01_status.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/results/02_run.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/results/03_cptorennes.sh
i=$((i+1))
done

echo "management node is $manage"