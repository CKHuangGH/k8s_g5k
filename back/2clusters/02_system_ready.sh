#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
third_octet=$(echo "$ip_address" | awk -F. '{print $3}')
git clone https://github.com/CKHuangGH/mck8s_vm.git
git clone https://github.com/CKHuangGH/acala.git
rm -rf /home/chuang/.ssh/known_hosts

for j in $(cat node_list)
do
scp -r /home/chuang/k8s_g5k/mck8s_vm root@$j:/root/
scp -r /home/chuang/k8s_g5k/acala root@$j:/root/
scp /home/chuang/.ssh/id_rsa root@$j:/root/.ssh
ssh -o StrictHostKeyChecking=no root@$j sudo apt-get update
ssh -o StrictHostKeyChecking=no root@$j sudo apt-get install vim -y
ssh -o StrictHostKeyChecking=no root@$j sudo apt install python3-pip -y
ssh -o StrictHostKeyChecking=no root@$j sudo git clone https://github.com/CKHuangGH/acala_error.git
ssh -o StrictHostKeyChecking=no root@$j sudo git clone https://github.com/CKHuangGH/k8s_google_injection.git
ssh -o StrictHostKeyChecking=no root@$j sudo pip3 install pandas
ssh -o StrictHostKeyChecking=no root@$j sudo pip3 install kubernetes
ssh -o StrictHostKeyChecking=no root@$j sudo pip3 install aiohttp
#ssh -o StrictHostKeyChecking=no root@$j mv /root/.kube/config /root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j scp -o StrictHostKeyChecking=no /root/.kube/config root@$manage:/root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j chmod 777 -r /root/mck8s_vm
ssh -o StrictHostKeyChecking=no root@$j chmod 777 -r /root/acala/
if 
i=$((i+1))
done

scp /home/chuang/.ssh/id_rsa root@10.158.$third_octet.3:/root/.ssh
scp -r /home/chuang/k8s_g5k/mck8s_vm root@10.158.$third_octet.3:/root/
scp node_list root@$manage:/root/mck8s_vm/node_list
echo "management node is $manage"