#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
git clone https://github.com/CKHuangGH/mck8s_vm.git
git clone https://github.com/CKHuangGH/rntsm.git
scp -r /home/chuang/k8s_g5k/mck8s_vm root@$manage:/root/
scp -r /home/chuang/k8s_g5k/rntsm root@$manage:/root/
scp node_list root@$manage:/root/mck8s_vm
rm -rf /home/chuang/.ssh/known_hosts

for j in $(cat node_list)
do
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
i=$((i+1))
done

echo "management node is $manage"