manage=$(awk NR==1 node_list)
scp conf.yaml root@$manage:/root/conf.yaml