#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
git clone https://github.com/CKHuangGH/exprbs.git
#git clone https://github.com/CKHuangGH/acala.git
#git clone https://github.com/CKHuangGH/k8s_google_injection.git
#git clone https://github.com/CKHuangGH/DASI.git
#git clone https://github.com/CKHuangGH/acala_error.git
rm -rf /home/chuang/.ssh/known_hosts

for j in $(cat node_list)
do
#scp ./install.sh root@$j:/root/
scp -r ./exprbs root@$j:/root/ &
scp /home/chuang/images/nginx.tar root@$j:/root/ &
#scp -r ./acala root@$j:/root/
#scp -r ./k8s_google_injection root@$j:/root/
#scp -r ./DASI root@$j:/root/
#scp -r ./acala_error root@$j:/root/
scp /home/chuang/.ssh/id_rsa root@$j:/root/.ssh &
done
sleep 10

for j in $(cat node_list)
do
ssh -o StrictHostKeyChecking=no root@$j scp -o StrictHostKeyChecking=no /root/.kube/config root@$manage:/root/.kube/cluster$i
ssh -o StrictHostKeyChecking=no root@$j chmod 777 -R /root/exprbs/
i=$((i+1))
done


ssh -o StrictHostKeyChecking=no root@10.$ip1.$ip2.3 chmod 777 -R /root/exprbs/
scp node_list root@$manage:/root/exprbs/kubernetes/node_list
scp node_list root@$manage:/root/exprbs/edgesys/ocm/node_list
scp node_list root@$manage:/root/exprbs/edgesys/mck8s/node_list
scp node_list root@$manage:/root/exprbs/edgesys/karmada/node_list
echo "management node is $manage"