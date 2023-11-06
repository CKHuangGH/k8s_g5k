manage=$(awk NR==1 node_list)
scp -o StrictHostKeyChecking=no conf.yaml root@$manage:/root/conf.yaml