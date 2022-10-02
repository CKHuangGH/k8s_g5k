python3 ./clusters/management.py &
sleep 30
python3 ./clusters/m1.py &
sleep 30
python3 ./clusters/m2.py &


chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04.del.sh