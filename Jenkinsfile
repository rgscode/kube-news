pipeline {

    agent any

    stages {

        stage('Build Docker Image') {
            steps {
                script {
                    dockerapp = docker.build("rafaelgomesx/kube-news:${env.BUILD_ID}", ".")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }


        stage('Deploy to kubernetes environment'){

            environment{
                tag_version = "${env.BUILD_ID}"
            }

            steps {
                withKubeConfig([credentialsId: 'kubeconfig']){
                    sh 'sed -i "s/{{TAG}}/$tag_version/g" deployment.yaml'
                    sh 'kubectl apply -f deployment.yaml'
                }
            }
        }

    }

}