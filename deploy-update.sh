#!/bin/bash

# Step 1: Deploy the new Blue container
docker stop blue-container
docker rm blue-container
docker build -f Dockerfile.blue -t blue-app .
docker run -d --name blue-container --network bluegreen-network -p 8080:80 blue-app

# Step 2: Test the Blue container
if curl -s http://blue-container:80 | grep "Blue Instance"; then
    echo "Blue container is healthy. Switching traffic to Blue."
    
    # Step 3: Update NGINX to point to Blue
    sed -i 's/green-container/blue-container/' nginx/nginx.conf
    docker exec nginx-proxy nginx -s reload
    
    # Step 4: Remove the old Green container and rename Blue to Green
    docker stop green-container
    docker rm green-container
    docker rename blue-container green-container
else
    echo "Blue container failed health check. Aborting."
    docker stop blue-container
    docker rm blue-container
fi
