folders=("mcdeploy-1" "mcdeploy-2" "mcdeploy-3" "mcdeploy-4" "mcdeploy-5")

for folder in "${folders[@]}"; do
    cd "$folder" || exit 1 
    chmod +x 04_del.sh     
    ./04_del.sh            
    cd ..                  
done