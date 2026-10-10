#!/bin/bash
# Frappe HR Codespace 自动部署 - 阶段1：拉代码 + 起容器
set -e

cd /workspaces
if [ ! -d hrms ]; then
  echo ">>> 克隆 frappe/hrms ..."
  git clone --depth 1 https://github.com/frappe/hrms.git
fi

cd /workspaces/hrms/docker
echo ">>> 启动 Docker 容器 (mariadb + redis + frappe/bench) ..."
docker compose up -d

echo ">>> 后台等待初始化完成并自动绑定访问域名（日志: /tmp/finish-setup.log）"
nohup bash /workspaces/HR/.devcontainer/finish-setup.sh > /tmp/finish-setup.log 2>&1 &

echo ">>> 容器已启动，Frappe HR 正在初始化（约15~25分钟）。"
echo ">>> 可执行 tail -f /tmp/finish-setup.log 观察进度。"
