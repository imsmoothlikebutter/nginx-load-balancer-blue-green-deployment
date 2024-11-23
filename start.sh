docker network create bluegreen-network
docker build -f Dockerfile.blue -t blue-app .
docker build -f Dockerfile.green -t green-app .
docker run -d --name blue-container --network bluegreen-network -p 8080:80 blue-app
docker run -d --name green-container --network bluegreen-network -p 8081:80 green-app
docker run -d --name nginx-proxy --network bluegreen-network -p 80:80 -v ${PWD}/nginx/nginx.conf:/etc/nginx/nginx.conf:ro nginx:alpine