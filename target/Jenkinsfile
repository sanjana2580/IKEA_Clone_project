pipeline {
    agent any

    tools{
        maven 'maven'
    }

    stages{
        stage('Check and remove container'){
            steps{
                script{
                    def containerExists = sh(script: "docker ps -q -f name=sanju", returnStdout: true).trim()
                    if (containerExists) {
                    sh "docker stop sanju"
                    sh "docker rm sanju"
                    }
                }
            }
        }
        stage('Build package'){
            steps{
                sh 'mvn clean package'
            }
        }
        stage('Create image'){
            steps{
                sh 'sudo docker build -t app /var/lib/jenkins/workspace/job/'
            }
        }
        stage('Assign tag'){
            steps{
                sh 'docker tag app sanjana255/app'
            }
        }
        stage('Push to dockerhub'){
            steps{
                sh 'echo "Biradar@24" | docker login -u "sanjana255" --password-stdin'
                sh 'docker push sanjana255/app'
            }
        }
        stage('Remove images'){
            steps{
                sh 'docker rmi -f $(docker images -q)'
            }
        }
        stage('Pull image from DockerHub'){
            steps{
                sh 'docker pull sanjana255/app'
            }
        }
        stage('Run a container'){
            steps{
                sh 'docker run -it -d --name sanju -p 8081:8080 sanjana255/app'
            }
        }
    }
    post {
        success {
            echo 'Deployment successful'
        }
        failure {
            sh 'docker rm -f sanju'
        }
        always{
            echo 'Deployed'
        }
    }

}