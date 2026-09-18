pipeline {
    agent any
    
    environment {
        DOCKER_HUB_USER = "sathwik0477" // Change this
        IMAGE_NAME      = "student-reg-war"
        REGION          = "us-east-1"
        CLUSTER_NAME    = "stud-reg-cluster"
    }

    stages {
        stage('Maven Build & Test') {
            steps {
                echo 'Building & Testing Application...'
                sh 'mvn clean package'
            }
        }

        stage('Docker Image Construction') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        echo 'Building and Pushing Docker Image...'
                        sh "docker build -t ${DOCKER_HUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER} ."
                        sh "docker tag ${DOCKER_HUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER} ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                        sh "echo $PASS | docker login -u $USER --password-stdin"
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:${BUILD_NUMBER}"
                        sh "docker push ${DOCKER_HUB_USER}/${IMAGE_NAME}:latest"
                    }
                }
            }
        }

        stage('K8s Deployment') {
            steps {
                script {
                    echo 'Updating Kubeconfig and Deploying to EKS...'
                    sh "aws eks update-kubeconfig --region ${REGION} --name ${CLUSTER_NAME}"
                    
                    // Using envsubst if you want to inject the build number into the manifest
                    // Otherwise, applying the latest tag works for static manifests
                    sh "kubectl apply -f deployment.yml"
                    sh "kubectl apply -f service.yml"
                    
                    // Force a rollout to ensure the new image is pulled
                    sh "kubectl rollout restart deployment/student-reg-app"
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}

