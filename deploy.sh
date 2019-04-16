docker build -t joshwhieb/multi-client:latest -t joshwhieb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t joshwhieb/multi-server:latest -t joshwhieb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t joshwhieb/multi-worker:latest -t joshwhieb/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push joshwhieb/multi-client:latest
docker push joshwhieb/multi-server:latest
docker push joshwhieb/multi-worker:latest

docker push joshwhieb/multi-client:$SHA
docker push joshwhieb/multi-server:$SHA
docker push joshwhieb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=joshwhieb/multi-server:$SHA
kubectl set image deployments/client-deployment client=joshwhieb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=joshwhieb/multi-worker:$SHA
