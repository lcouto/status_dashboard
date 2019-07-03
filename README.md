# status_dashboard

This assumes you have a gcloud account and terraform12 installed.

First deploy terraform environment. cd in terraform directory, set vars and make plan, make apply

Dockerize the apps
export PROJECT_ID="$(gcloud config get-value project -q)"
docker build -t gcr.io/${PROJECT_ID}/status-dashboard:v1 .
gcloud docker -- push gcr.io/${PROJECT_ID}/status-dashboard:v1

docker build -f Dockerfile.botsA -t gcr.io/${PROJECT_ID}/mac_bot_a:v1 .
gcloud docker -- push gcr.io/${PROJECT_ID}/mac_bot_a:v1

docker build -f Dockerfile.botsB -t gcr.io/${PROJECT_ID}/mac_bot_b:v1 .
gcloud docker -- push gcr.io/${PROJECT_ID}/mac_bot_b:v1

kubectl apply -f status_dashboard.yaml

kubectl get service status-dashboard
endpoint is {{service ip}}/status
