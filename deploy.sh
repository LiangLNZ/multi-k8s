#build image
docker build -t dancingdumpling/multi-client:latest -t dancingdumpling/multi-client:$SHA ./client 
docker build -t dancingdumpling/multi-server:latest -t dancingdumpling/multi-server:$SHA ./server
docker build -t dancingdumpling/multi-worker:latest -t dancingdumpling/multi-worker:$SHA ./worker


#push to docker hub
docker push dancingdumpling/multi-client:latest
docker push dancingdumpling/multi-client:$SHA

docker push dancingdumpling/multi-server:latest
docker push dancingdumpling/multi-server:$SHA

docker push dancingdumpling/multi-worker:latest
docker push dancingdumpling/multi-worker:$SHA

kubectl apply -f ./k8s
#rebuild k8s with latest image 
kubectl set image deployment/client-deployment client=dancingdumpling/multi-client:$SHA
kubectl set image deployment/server-deployment server=dancingdumpling/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=dancingdumpling/multi-worker:$SHA