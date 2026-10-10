#!/bin/bash
# Frappe HR Codespace 自动部署 - 阶段2：等待初始化 + 绑定域名
cd /workspaces/hrms/docker

echo "[wait] 等待 Frappe HR 初始化完成（bench start 监听 8000）..."
until docker compose logs frappe 2>&1 | grep -q "Running on http"; do
  sleep 30
done

echo "[config] 绑定 Codespaces 域名到站点 hrms.localhost ..."
docker compose exec frappe bash -c "cd /home/frappe/frappe-bench && bench --site hrms.localhost set-config host_name https://${CODESPACE_NAME}-8000.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN:-app.github.dev} && bench --site hrms.localhost clear-cache"

echo "==================================================="
echo " DONE! Frappe HR 部署完成"
echo " 访问: 端口面板打开 8000 转发地址"
echo " 账号: Administrator  密码: admin"
echo "==================================================="
