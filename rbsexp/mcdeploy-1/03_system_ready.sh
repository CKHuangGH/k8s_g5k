#!/bin/bash
i=0
manage=$(awk NR==1 node_list)
git clone https://github.com/CKHuangGH/exprbs.git
git clone https://github.com/CKHuangGH/acala.git
git clone https://github.com/CKHuangGH/k8s_google_injection.git
#git clone https://github.com/CKHuangGH/DASI.git
#git clone https://github.com/CKHuangGH/acala_error.git
rm -rf /home/chuang/.ssh/known_hosts

for j in $(cat node_list)
do
#scp ./install.sh root@$j:/root/
scp -r ./exprbs root@$j:/root/
scp -r ./acala root@$j:/root/
scp -r ./k8s_google_injection root@$j:/root/
#scp -r ./DASI root@$j:/root/
#scp -r ./acala_error root@$j:/root/
scp /home/chuang/.ssh/id_rsa root@$j:/root/.ssh
ssh -o StrictHostKeyChecking=no root@$j scp -o StrictHostKeyChecking=no /root/.kube/config root@$manage:/root/.kube/cluster$i
#ssh -o StrictHostKeyChecking=no root@$j chmod 777 -R /root/exprbs/large-scale/
ssh -o StrictHostKeyChecking=no root@$j chmod 777 -R /root/exprbs/0-kubefed/
i=$((i+1))
done

while read line
do 
echo $line
ip1=$(echo $line | cut -d "." -f 2)
ip2=$(echo $line | cut -d "." -f 3)
break
done < node_list


scp /home/chuang/.ssh/id_rsa root@10.$ip1.$ip2.3:/root/.ssh
scp -r ./exprbs root@10.$ip1.$ip2.3:/root/
ssh -o StrictHostKeyChecking=no root@10.$ip1.$ip2.3 chmod 777 -R /root/exprbs/0-kubefed/
scp node_list root@$manage:/root/exprbs/0-kubefed/node_list
echo "management node is $manage"