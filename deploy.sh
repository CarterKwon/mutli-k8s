docker build -t carterkwon/multi-client:latest -t carterkwon/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t carterkwon/multi-server:latest -t carterkwon/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t carterkwon/multi-worker:latest -t carterkwon/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push carterkwon/multi-client:latest
docker push carterkwon/multi-server:latest
docker push carterkwon/multi-worker:latest
docker push carterkwon/multi-client:$SHA
docker push carterkwon/multi-server:$SHA
docker push carterkwon/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=carterkwon/multi-server:$SHA
kubectl set image deployments/client-deployment client=carterkwon/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=carterkwon/multi-worker:$SHA