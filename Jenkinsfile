pipeline{
    agent any
    tools{
        maven 'maven'
    }
    stages{
        stage('Build maven project'){
            steps{
               checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/rishi0803/Finance.git']])
                sh 'mvn clean install'
            }
        }
        stage('Test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Build docker image'){
            steps{
                script{
                    sh 'docker build -t rishi0803/devops-project .'
                }
            }
        }
        stage('push the docker image to hub'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]) {
                    sh 'docker login -u rishi0803 -p ${dockerhubpwd}'    
}
                    sh 'docker push rishi0803/devops-project'
                }
                
            }
            
        }
        stage('Execute Playbook'){
            steps{
               ansiblePlaybook credentialsId: 'jenkinsAnsible', disableHostKeyChecking: true, installation: 'Ansible', inventory: 'hosts', playbook: 'ansible-playbook.yml'
            }
        }
    }
}
