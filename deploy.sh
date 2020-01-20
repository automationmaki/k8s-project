docker build -t automationmaki/multi-client:latest -t automationmaki/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t automationmaki/multi-server:latest -t automationmaki/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t automationmaki/multi-worker:latest -t automationmaki/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push automationmaki/multi-client:latest
docker push automationmaki/multi-server:latest
docker push automationmaki/multi-worker:latest

docker push automationmaki/multi-client:$SHA
docker push automationmaki/multi-server:$SHA
docker push automationmaki/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=automationmaki/multi-server:$SHA
kubectl set image deployments/client-deployment client=automationmaki/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=automationmaki/multi-worker:$SHA