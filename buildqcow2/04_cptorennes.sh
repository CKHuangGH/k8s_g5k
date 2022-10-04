virsh list
virsh shutdown virtual-158-0-2
sleep 5
cd /var/lib/libvirt/images/enos_vmong5
cp enos_vmong5k-base-image.qcow2 new-master
qemu-img rebase -p -b new-master virtual-158-0-2
qemu-img commit virtual-158-0-2
qemu-img convert -p -c -O qcow2 new-master images.qcow2
qemu-img info new-master
scp -o StrictHostKeyChecking=no -r images.qcow2 chuang@172.16.111.106:/home/chuang/images