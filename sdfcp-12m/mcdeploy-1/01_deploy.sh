python3 ./cluster/management.py &
sleep 30
python3 ./cluster/m1.py &
python3 ./cluster/m2.py &
python3 ./cluster/m3.py
echo "wait for 60 secs"
sleep 120

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04_del.sh

. ./03_system_ready.sh