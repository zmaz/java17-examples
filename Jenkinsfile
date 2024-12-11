pipeline {
    agent any  // Runs the pipeline on any available agent (node)
// asdfasdfsadf

    environment {
        KUBECONFIG_CREDENTIAL_ID = 'kubeconfig'  // Jenkins credential ID for kubeconfig file
    }

    stages { /*
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                git branch: 'master', url: 'https://github.com/zmaz/java17-examples.git'
            }
        }
        stage('Test') {
            steps {
                // Example: Run unit tests
                sh './mvnw test'
            }
        }
        stage('Build') {
            steps {
                // Example: Maven build
                sh './mvnw clean install'
            }
        }
        stage('Docker build') {
            steps {
                // Docker build 
                sh 'docker build -t example_jdk17_master:$BUILD_NUMBER .'
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker login -u $username -p $password'
                    sh 'docker tag example_jdk17_master:$BUILD_NUMBER zmaz/kubernetes-master:$BUILD_NUMBER'
                    sh 'docker push zmaz/kubernetes-master:$BUILD_NUMBER'
                }
            }
        } */
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withCredentials([file(credentialsId: "${KUBECONFIG_CREDENTIAL_ID}", variable: 'KUBECONFIG')]) {
                        // Deploy the app to Kubernetes
                        sh 'kubectl get nodes'
                        //sh 'kubectl apply -f deployment.yaml'
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline succeeded! Send notification, etc.'
        }
        failure {
            echo 'Pipeline failed! Send notification, etc.'
        }
        always { 
            echo "Pipeline executed! Send notification, etc."
            archiveArtifacts artifacts: 'target/*.jar', followSymlinks: false
            sh "docker rmi example_jdk17_master:$BUILD_NUMBER"
            cleanWs()
        }
    }
}
