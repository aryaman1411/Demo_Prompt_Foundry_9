Here is a simple example of a Dockerfile and a containerization script for a Node.js based web application. Please modify it according to your application's specific requirements and dependencies.

Dockerfile:
```Dockerfile
# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Bundle the app source inside the Docker image
COPY . .

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define the command to run the app
CMD [ "node", "server.js" ]
```

Containerization script:
```bash
#!/bin/bash

# Build the Docker image
docker build -t my-web-app .

# Run the Docker container
docker run -p 8080:8080 -d my-web-app
```

To run the script, save it to a file (e.g., `run.sh`), give it execute permissions (`chmod +x run.sh`), and then run it (`./run.sh`).

Please note that this is a very basic example. Depending on your application, you might need to add more steps to your Dockerfile (e.g., for handling environment variables, setting up a non-root user, etc.) and your script (e.g., for handling Docker networks, volumes, etc.).