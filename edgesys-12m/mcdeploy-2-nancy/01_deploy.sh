python3 ./cluster/management.py
sleep 60
python3 ./cluster/m1.py &
python3 ./cluster/m2.py
# python3 ./cluster/m3.py &
# python3 ./cluster/m4.py &
# python3 ./cluster/m5.py &
# python3 ./cluster/m6.py &
# python3 ./cluster/m7.py &
# python3 ./cluster/m8.py &
# python3 ./cluster/m9.py &

# python3 ./cluster/m10.py
# python3 ./cluster/m41.py &
# python3 ./cluster/m42.py &
# python3 ./cluster/m43.py &
# python3 ./cluster/m44.py &
# python3 ./cluster/m45.py &
# python3 ./cluster/m46.py &
# python3 ./cluster/m47.py &
# python3 ./cluster/m48.py &
# python3 ./cluster/m49.py &
# python3 ./cluster/m50.py

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04_del.sh

echo "wait for 60 secs"
for (( i=60; i>0; i-- )); do
    echo "$i secs..."
    sleep 1
. ./03_system_ready.sh