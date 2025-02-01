#!/bin/bash
i=0

for j in $(cat node_list)
do
ssh -o StrictHostKeyChecking=no root@$j chmod 777 -R /root/exprbs/
i=$((i+1))
done