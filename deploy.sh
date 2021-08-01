docker build -t pedro357bm/multi-client:latest -t pedro357bm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pedro357bm/multi-server:latest -t pedro357bm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pedro357bm/multi-worker:latest -t pedro357bm/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pedro357bm/multi-client:latest 
docker push pedro357bm/multi-server:latest
docker push pedro357bm/multi-worker:latest

docker push pedro357bm/multi-client:$SHA 
docker push pedro357bm/multi-server:$SHA 
docker push pedro357bm/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pedro357bm/multi-server:$SHA
kubectl set image deployments/client-deployment client=pedro357bm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pedro357bm/multi-worker:$SHA