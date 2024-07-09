pipeline {
    agent any  // Runs the pipeline on any available agent (node)
    // comment added 

    stages {
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
                withCredentials([usernamePassword(credentialsId: 'harbor', passwordVariable: 'password', usernameVariable: 'username')]) {
                    sh 'docker login -u $username -p $password harbor.devops.com'
                    sh 'docker tag example_jdk17_master:$BUILD_NUMBER harbor.devops.com/example-project/example_jdk17_master:$BUILD_NUMBER'
                    sh 'docker push harbor.devops.com/example-project/example_jdk17_master:$BUILD_NUMBER'
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
