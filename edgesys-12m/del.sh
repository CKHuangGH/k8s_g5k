folders=("/home/chuang/k8s_g5k/edgesys-12m/mcdeploy-1" "/home/chuang/k8s_g5k/edgesys-12m/mcdeploy-2" "/home/chuang/k8s_g5k/edgesys-12m/mcdeploy-3" "/home/chuang/k8s_g5k/edgesys-12m/mcdeploy-4")

for folder in "${folders[@]}"; do
    cd "$folder" || exit 1 
    chmod +x 04_del.sh     
    ./04_del.sh            
    cd ..                  
done