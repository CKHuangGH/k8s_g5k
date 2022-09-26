#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
git clone https://github.com/CKHuangGH/mck8s_vm.git
git clone https://github.com/CKHuangGH/acala.git
git clone https://github.com/CKHuangGH/k8s_google_injection.git
git clone https://github.com/CKHuangGH/acala_error.git
rm -rf /home/chuang/.ssh/known_hosts

for j in $(cat node_list)
do
scp ./install.sh root@$j:/root/
scp -r ./mck8s_vm root@$j:/root/
scp -r ./acala root@$j:/root/
scp -r ./k8s_google_injection root@$j:/root/
scp -r ./acala_error root@$j:/root/
scp /home/chuang/.ssh/id_rsa root@$j:/root/.ssh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 ./install.sh
ssh -o StrictHostKeyChecking=no root@$j sh ./install.sh
# ssh -o StrictHostKeyChecking=no root@$j sudo apt-get install vim -y
# ssh -o StrictHostKeyChecking=no root@$j sudo apt install python3-pip -y
# ssh -o StrictHostKeyChecking=no root@$j sudo pip3 install pandas
# ssh -o StrictHostKeyChecking=no root@$j sudo pip3 install kubernetes
# ssh -o StrictHostKeyChecking=no root@$j sudo pip3 install aiohttp
# #ssh -o StrictHostKeyChecking=no root@$j mv /root/.kube/config /root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j scp -o StrictHostKeyChecking=no /root/.kube/config root@$manage:/root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/acala/management/build.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/acala/member/build.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/00_formcdeploy.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/01_combineAll.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/02_acalavalue.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/03_createmember.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/04_mck8s-2.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/05_joining_test.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/06_deployment.sh
ssh -o StrictHostKeyChecking=no root@$j chmod 777 /root/mck8s_vm/mcdeploy/createvalue.sh
i=$((i+1))
done
scp /home/chuang/.ssh/id_rsa root@10.158.0.3:/root/.ssh
scp -r ./mck8s_vm root@10.158.0.3:/root/
scp node_list root@$manage:/root/mck8s_vm/mcdeploy/node_list
echo "management node is $manage"