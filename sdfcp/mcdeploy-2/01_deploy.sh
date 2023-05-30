python3 management.py &
python3 management-1.py &
python3 management-2.py 
#sleep 35
python3 m1.py

sleep 30

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04_del.sh

. ./03_system_ready.sh