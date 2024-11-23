docker stop blue-container
docker rm blue-container
docker build -f Dockerfile.blue -t blue-app .
docker run -d --name blue-container --network bluegreen-network -p 8080:80 blue-app
docker exec nginx-proxy nginx -s reload
