#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
git clone https://github.com/CKHuangGH/mck8s_vm.git
git clone https://github.com/CKHuangGH/rntsm.git
scp -r /home/chuang/k8s_g5k/mck8s_vm root@$manage:/root/
scp -r /home/chuang/k8s_g5k/rntsm root@$manage:/root/

echo "management node is $manage"
for j in $(cat node_list)
do
ssh -o StrictHostKeyChecking=no root@$j mv /root/.kube/config /root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j scp /root/.kube/cluster$i root@$manage:/root/.kube
i=$((i+1))
done
