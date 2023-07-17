pipeline {
    agent {
        kubernetes {
            yaml '''
        apiVersion: v1
        kind: Pod
        spec:
          containers:
          - name: kubectl
            image: smesch/kubectl
            command:
            - cat
            tty: true
            volumeMounts:
             - mountPath: /root/.kube
               name: kube-config
          - name: docker
            image: docker:latest
            command:
            - cat
            tty: true
            volumeMounts:
             - mountPath: /var/run/docker.sock
               name: docker-sock
          volumes:
          - name: docker-sock
            hostPath:
              path: /var/run/docker.sock
          - name: kube-config
            hostPath:
              path: /tmp
        '''
        }
    }
    stages {
        stage('Checkout Source') {
            steps {
                git 'https://github.com/TheDeathFar/CTFd'
            }
        }
        stage('Build image') {
            steps {
                script {
                    container('docker') {
                        sh 'docker build -t deathfar/ctfd-app .'
                    }
                }
            }
        }
        stage('Push image to Hub'){
            steps {
                script {
                    container('docker') {
                        withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                            sh 'docker login -u deathfar -p ${dockerhubpwd}'
                        }
                        sh 'docker push deathfar/ctfd-app'
                    }
                }
            }
        }
        stage('Deploying ctfd container to Kubernetes') {
            steps {
                script {
                    container('kubectl') {
                        sh 'kubectl apply -f deployment'
                    }
                }
            }
        }
    }
}
