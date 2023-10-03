folders=("/home/chuang/k8s_g5k/sdfcp-stress/mcdeploy-1" "/home/chuang/k8s_g5k/sdfcp-stress/mcdeploy-2" "/home/chuang/k8s_g5k/sdfcp-stress/mcdeploy-3" "/home/chuang/k8s_g5k/sdfcp-stress/mcdeploy-4" "/home/chuang/k8s_g5k/sdfcp-stress/mcdeploy-5" "/home/chuang/k8s_g5k/sdfcp-stress/mcdeploy-6")

for folder in "${folders[@]}"; do
    cd "$folder" || exit 1 
    chmod +x 04_del.sh     
    ./04_del.sh            
    cd ..                  
done