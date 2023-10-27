folders=("/home/chuang/k8s_g5k/sdfcp-m21/mcdeploy-1" "/home/chuang/k8s_g5k/sdfcp-m21/mcdeploy-2" "/home/chuang/k8s_g5k/sdfcp-m21/mcdeploy-3")

for folder in "${folders[@]}"; do
    cd "$folder" || exit 1 
    chmod +x 04_del.sh     
    ./04_del.sh            
    cd ..                  
done