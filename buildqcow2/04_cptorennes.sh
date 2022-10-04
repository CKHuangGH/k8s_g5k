virsh list
virsh shutdown virtual-158-0-2
sleep 5
cd /var/lib/libvirt/images/enos_vmong5

scp -o StrictHostKeyChecking=no -r images.qcow2 chuang@172.16.111.106:/home/chuang/images