import re

# 循环遍历50个文件
for i in range(1, 51):
    # 构造文件名
    filename = f"m{i}.py"
    
    try:
        # 打开文件进行读取
        with open(filename, 'r') as file:
            content = file.read()
        
        # 使用正则表达式搜索并替换
        pattern = r"m1-sdfcp-(\d+)"
        content = re.sub(pattern, f"m1-sdfcp-{i}", content)
        
        # 将修改后的内容写回文件
        with open(filename, 'w') as file:
            file.write(content)
        
        print(f"成功处理文件 {filename}")
    
    except FileNotFoundError:
        print(f"文件 {filename} 不存在")
    except Exception as e:
        print(f"处理文件 {filename} 时发生错误: {str(e)}")