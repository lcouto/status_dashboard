# status_dashboard
This app reports and listens for mac addresses and last check in time.

This assumes you have a kubectl, a gcloud account and terraform12 installed.

kubectl - brew install kubernetes-cli
gcloud - https://cloud.google.com/sdk/
terraform12 - https://learn.hashicorp.com/terraform/getting-started/install.html

First deploy the terraform environment. cd into terraform directory, set vars and 
`make plan`
`make apply`

Set your gcp project: `gcloud config set project [PROJECT_ID]`
Get Kubernetes creds: `gcloud container clusters get-credentials [cluster-name] --region [region]`


Then Dockerize the apps and push to the gcr
`export PROJECT_ID="$(gcloud config get-value project -q)"`
`docker build -t gcr.io/${PROJECT_ID}/status-dashboard:v1 .`
`gcloud docker -- push gcr.io/${PROJECT_ID}/status-dashboard:v1`

`docker build -f Dockerfile.botsA -t gcr.io/${PROJECT_ID}/mac_bot_a:v1 .`
`gcloud docker -- push gcr.io/${PROJECT_ID}/mac_bot_a:v1`

`docker build -f Dockerfile.botsB -t gcr.io/${PROJECT_ID}/mac_bot_b:v1 .`
`gcloud docker -- push gcr.io/${PROJECT_ID}/mac_bot_b:v1`

deploy the apps to your gcp environment.
note, update the image tag in the yaml file with your PROJECT docker tag
`kubectl apply -f status_dashboard.yaml`

`kubectl get service status-dashboard`
endpoint is {{service ip}}/status
