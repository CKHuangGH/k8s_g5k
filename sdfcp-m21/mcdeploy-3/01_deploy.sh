python3 ./cluster/management.py
sleep 60
# python3 ./cluster/m1.py &
# python3 ./cluster/m2.py &
# python3 ./cluster/m3.py &
# python3 ./cluster/m4.py &
# python3 ./cluster/m5.py &
# python3 ./cluster/m6.py &
# python3 ./cluster/m7.py &
# python3 ./cluster/m8.py &
# python3 ./cluster/m9.py &
# python3 ./cluster/m10.py &
# python3 ./cluster/m11.py &
# python3 ./cluster/m12.py &
# python3 ./cluster/m13.py &
# python3 ./cluster/m14.py &
# python3 ./cluster/m15.py &
# python3 ./cluster/m16.py &
# python3 ./cluster/m17.py &
# python3 ./cluster/m18.py &
# python3 ./cluster/m19.py &
# python3 ./cluster/m20.py &
# python3 ./cluster/m21.py &
# python3 ./cluster/m22.py &
# python3 ./cluster/m23.py &
# python3 ./cluster/m24.py &
# python3 ./cluster/m25.py &
# python3 ./cluster/m26.py &
# python3 ./cluster/m27.py &
# python3 ./cluster/m28.py &
# python3 ./cluster/m29.py &
# python3 ./cluster/m30.py &
# python3 ./cluster/m31.py &
# python3 ./cluster/m32.py &
# python3 ./cluster/m33.py &
# python3 ./cluster/m34.py &
# python3 ./cluster/m35.py &
# python3 ./cluster/m36.py &
# python3 ./cluster/m37.py &
# python3 ./cluster/m38.py &
# python3 ./cluster/m39.py &
# python3 ./cluster/m40.py &
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

echo "wait for 60 secs"
sleep 900

chmod 777 02_check.sh
chmod 777 03_system_ready.sh
chmod 777 04_del.sh

. ./03_system_ready.sh