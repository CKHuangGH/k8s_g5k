import os

# 设置文件所在的目录
directory = 'C:\\Users\\Chih-Kai HUANG\\Documents\\GitHub\\k8s_g5k\\sdfcp-12m\\mcdeploy-1\\delcluster'  # 将路径替换为你的文件所在的目录

# 获取目录中的所有文件
files = os.listdir(directory)

# 初始化计数器
count = 1

# 循环重命名文件
for file in files:
    # 构建新的文件名
    new_name = f'm{count}.py'
    
    # 构建完整的文件路径
    old_path = os.path.join(directory, file)
    new_path = os.path.join(directory, new_name)
    
    # 重命名文件
    os.rename(old_path, new_path)
    
    # 增加计数器
    count += 1