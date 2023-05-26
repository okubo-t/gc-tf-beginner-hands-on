#!/bin/bash
set -e
sudo apt-get update
sudo apt-get install -y nginx
sudo systemctl enable nginx
sudo systemctl start nginx

#
# psql クライアントのインストール
# docs: https://cloud.google.com/sql/docs/postgres/connect-admin-ip?hl=ja#install-mysql-client
#
sudo apt-get install -y postgresql-client

#
# Cloud SQL Auth Proxy クライアントのインストール
# docs: https://cloud.google.com/sql/docs/postgres/connect-instance-auth-proxy?hl=ja#install-proxy
#
sudo curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.1.2/cloud-sql-proxy.linux.amd64
sudo chmod +x cloud-sql-proxy

#
# Ops エージェントのインストール
# docs: https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent/installation?hl=ja#joint-install
#
sudo curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

#
# nginx の統合
# docs: https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent/third-party/nginx?hl=ja#configure-instance
#
#sudo tee /etc/nginx/conf.d/status.conf > /dev/null << EOF
#server {
#    listen 80;
#    server_name 127.0.0.1;
#    location /nginx_status {
#        stub_status on;
#        access_log off;
#        allow 127.0.0.1;
#        deny all;
#    }
#    location / {
#       root /dev/null;
#    }
#}
#EOF
#sudo service nginx reload
#sudo curl http://127.0.0.1:80/nginx_status

#
# nginx 用の Ops エージェントを構成する
# docs: https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent/third-party/nginx?hl=ja#configure-agent
#
# Create a back up of the existing file so existing configurations are not lost.
#sudo cp /etc/google-cloud-ops-agent/config.yaml /etc/google-cloud-ops-agent/config.yaml.bak

# Configure the Ops Agent.
#sudo tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
#metrics:
#  receivers:
#    nginx:
#      type: nginx
#      stub_status_url: http://127.0.0.1:80/nginx_status
#  service:
#    pipelines:
#      nginx:
#        receivers:
#          - nginx
#logging:
#  receivers:
#    nginx_access:
#      type: nginx_access
#    nginx_error:
#      type: nginx_error
#  service:
#    pipelines:
#      nginx:
#        receivers:
#          - nginx_access
#          - nginx_error
#EOF
#sudo service google-cloud-ops-agent restart
#sleep 60