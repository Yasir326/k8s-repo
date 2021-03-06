docker build -t yasir326/multi-client:latest -t yasir326/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yasir326/multi-server:latest -t yasir326/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yasir326/multi-worker:latest -t yasir326/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yasir326/multi-client:latest
docker push yasir326/multi-server:latest
docker push yasir326/multi-worker:latest

docker push yasir326/multi-client:$SHA
docker push yasir326/multi-server:$SHA
docker push yasir326/multi-worker:$SHA

kubectl apply -f k8s
# kubectl set image deployments/server-deployment server=yasir326/multi-server
kubectl set image deployments/server-deployment server=yasir326/multi-server:$SHA
kubectl set image deployments/client-deployment client=yasir326/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yasir326/multi-worker:$SHA