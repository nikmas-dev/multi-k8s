docker build -t nikmasdev/multi-client:latest -t nikmasdev/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikmasdev/multi-server:latest -t nikmasdev/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikmasdev/multi-worker:latest -t nikmasdev/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikmasdev/multi-client:latest
docker push nikmasdev/multi-client:$SHA

docker push nikmasdev/multi-server:latest
docker push nikmasdev/multi-server:$SHA

docker push nikmasdev/multi-worker:latest
docker push nikmasdev/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nikmasdev/multi-client:$SHA
kubectl set image deployments/server-deployment server=nikmasdev/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nikmasdev/multi-worker:$SHA