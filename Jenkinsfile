pipeline {
    agent any  // Runs the pipeline on any available agent (node)

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from Git repository
                git branch: 'bugfix/example-bugfix-branch', url: 'https://github.com/zmaz/java17-examples.git'
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
                sh 'docker build -t example_jdk17:$BUILD_NUMBER .'
            }
        }
        stage('Push Docker Image') {
            steps {
                // Login to harbor and push docker image
                sh 'docker login -u devops -p "DevOps@123" harbor.devops.com'
                sh 'docker tag example_jdk17:$BUILD_NUMBER harbor.devops.com/example-project/example_jdk17:$BUILD_NUMBER'
                sh 'docker push harbor.devops.com/example-project/example_jdk17:$BUILD_NUMBER'
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
            cleanWs()
        }
    }
}
