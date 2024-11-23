docker stop green-container
docker rm green-container
docker build -f Dockerfile.green -t green-app .
docker run -d --name green-container --network bluegreen-network -p 8081:80 green-app
docker exec nginx-proxy nginx -s reload