# CICD HTML Demo

A simple demonstration of deploying a static HTML page using Docker and automating the process with a Jenkins pipeline.

## Project Purpose

The repository contains a single `index.html` file. The goal is to serve this file via an Nginx web server running inside a Docker container. A Jenkins Declarative Pipeline is provided to build the Docker image and deploy the container automatically whenever the repository is updated.

## Required Tools

- **Git**: For source control.
- **Docker**: To build and run the container image.
- **Jenkins**: To run the CI/CD pipeline. A Jenkins installation with Docker access (often by running the Jenkins service on a host with Docker installed) is assumed.

## Manual Build and Run

You can build and start the container locally without Jenkins using the following commands:

```sh
# build the image (run from project root)
docker build -t cicd-html-demo-image .

# stop and remove any previous container (optional)
docker stop cicd-html-demo || true
docker rm cicd-html-demo || true

# run the container mapping port 8080 to 80
docker run -d --name cicd-html-demo -p 8080:80 cicd-html-demo-image
```

Once running, the HTML page is accessible at: http://localhost:8080/

To verify the container is serving the file correctly, open the URL in a browser or use `curl http://localhost:8080/`.

## Jenkins Pipeline

The `Jenkinsfile` defines a Declarative Pipeline composed of the following stages:

1. **Checkout**: Pulls the latest code from the GitHub repository.
2. **Build Image**: Uses Docker to build an image named `cicd-html-demo-image` from the `Dockerfile`.
3. **Stop Old Container**: Stops a container named `cicd-html-demo` if it's already running.
4. **Remove Old Container**: Removes the stopped or existing container to avoid name collisions.
5. **Run Container**: Starts a new container in detached mode, mapping host port 8080 to container port 80, using the image just built.

After the pipeline completes successfully, the application can be accessed at http://localhost:8080/.

### Notes

- The Jenkins agent running this pipeline must have permission to execute Docker commands (e.g. be part of the `docker` group or run in Docker-in-Docker setup).
- The pipeline is written in a production style with environment variables and explicit error handling using `|| true` so it doesn't fail if stopping/removing a non-existent container.

Enjoy automated deployment of your static website!  
