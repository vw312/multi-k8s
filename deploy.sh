docker build -t vw312/multi-client:latest -t vw312/multi-client:$SHA ./client 
docker build -t vw312/multi-server:latest -t vw312/multi-server:$SHA ./server 
docker build -t vw312/multi-worker:latest -t vw312/multi-worker:$SHA ./worker 

docker push vw312/multi-client:latest
docker push vw312/multi-server:latest
docker push vw312/multi-worker:latest

docker push vw312/multi-client:$SHA
docker push vw312/multi-server:$SHA
docker push vw312/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vw312/multi-server:$SHA
kubectl set image deployments/client-deployment client=vw312/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vw312/multi-worker:$SHA