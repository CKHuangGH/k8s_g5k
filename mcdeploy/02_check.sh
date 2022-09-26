for j in $(cat node_list)
do
echo $j
ssh -o StrictHostKeyChecking=no root@$j kubectl get node
done