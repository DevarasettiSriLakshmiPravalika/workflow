pipeline {
    agent any

    environment {
        IMAGE_NAME = "cicd-html-demo-image"
        CONTAINER_NAME = "cicd-html-demo"
        PORT_MAPPING = "8080:80"
    }

    stages {
        stage('Checkout') {
            steps {
                // pull the repository containing index.html and pipeline files
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                script {
                    // build a docker image from the Dockerfile in workspace
                    docker.build(env.IMAGE_NAME)
                }
            }
        }

        stage('Stop Old Container') {
            steps {
                script {
                    // attempt to stop any running container with the same name
                    sh "docker stop ${env.CONTAINER_NAME} || true"
                }
            }
        }

        stage('Remove Old Container') {
            steps {
                script {
                    // remove the container if it exists (stopped or exited)
                    sh "docker rm ${env.CONTAINER_NAME} || true"
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    // run the newly built image in detached mode
                    sh "docker run -d --name ${env.CONTAINER_NAME} -p ${env.PORT_MAPPING} ${env.IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment complete. Access the app at http://localhost:8080"
        }
        failure {
            echo "Pipeline failed. Check logs for details."
        }
    }
}
