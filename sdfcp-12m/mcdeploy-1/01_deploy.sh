python3 ./cluster/management.py
sleep 30
python3 ./cluster/m1.py &
python3 ./cluster/m2.py &
python3 ./cluster/m3.py &
python3 ./cluster/m4.py &
python3 ./cluster/m5.py &
python3 ./cluster/m6.py &
python3 ./cluster/m7.py &
python3 ./cluster/m8.py &
python3 ./cluster/m9.py &
python3 ./cluster/m10.py &
python3 ./cluster/m11.py &
python3 ./cluster/m12.py &
python3 ./cluster/m13.py &
python3 ./cluster/m14.py &
python3 ./cluster/m15.py &
python3 ./cluster/m16.py &
python3 ./cluster/m17.py &
python3 ./cluster/m18.py &
python3 ./cluster/m19.py &
python3 ./cluster/m20.py &
python3 ./cluster/m21.py &
python3 ./cluster/m22.py &
python3 ./cluster/m23.py &
python3 ./cluster/m24.py &
python3 ./cluster/m25.py &
python3 ./cluster/m26.py &
python3 ./cluster/m27.py &
python3 ./cluster/m28.py &
python3 ./cluster/m29.py &
python3 ./cluster/m30.py

echo "wait for 60 secs"
sleep 300

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04_del.sh

. ./03_system_ready.sh