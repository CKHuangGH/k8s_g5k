python3 management.py &
sleep 40
python3 m1.py &
sleep 40
python3 m2.py &
sleep 40
python3 m3.py &
chmod 777 02_system_ready.sh
chmod 777 03_del.sh

for j in $(cat node_list)
do
ssh -o StrictHostKeyChecking=no root@$j kubectl get node
done