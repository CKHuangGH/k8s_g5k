python3 management.py
#sleep 35
python3 m1.py &
sleep 5
python3 m2.py &
sleep 5
python3 m3.py &
sleep 5
python3 m4.py &
sleep 5
python3 m5.py
sleep 5

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04_del.sh

. /03_system_ready.sh