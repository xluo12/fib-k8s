docker build -t xluo12/multi-client:latest -t xluo12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xluo12/multi-server:latest -t xluo12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xluo12/multi-worker:latest -t xluo12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xluo12/multi-client:latest
docker push xluo12/multi-server:latest
docker push xluo12/multi-worker:latest

docker push xluo12/multi-client:$SHA
docker push xluo12/multi-server:$SHA
docker push xluo12/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xluo12/multi-server:$SHA
kubectl set image deployments/client-deployment client=xluo12/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xluo12/multi-worker:$SHA