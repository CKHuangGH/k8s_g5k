python3 ./clusters/management.py &
sleep 4
python3 ./clusters/m1.py &
sleep 4
python3 ./clusters/m2.py &
sleep 4
python3 ./clusters/m3.py &
sleep 4
python3 ./clusters/m4.py &
sleep 4
python3 ./clusters/m5.py &
sleep 4
python3 ./clusters/m6.py &
sleep 4
python3 ./clusters/m7.py &
sleep 4
python3 ./clusters/m8.py &
sleep 4
python3 ./clusters/m9.py &
sleep 4
python3 ./clusters/m10.py &

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04.del.sh