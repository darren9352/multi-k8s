docker build -t darren9352/multi-client:latest -t darren9352/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t darren9352/multi-server:latest -t darren9352/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t darren9352/multi-worker:latest -t darren9352/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push darren9352/multi-client:latest
docker push darren9352/multi-server:latest
docker push darren9352/multi-worker:latest

docker push darren9352/multi-client:$SHA
docker push darren9352/multi-server:$SHA
docker push darren9352/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=darren9352/multi-server:$SHA
kubectl set image deployments/client-deployment client=darren9352/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=darren9352/multi-worker:$SHA