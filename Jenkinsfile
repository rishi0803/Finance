pipeline{
    environment{
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
    agent any
    tools{
        maven 'maven'
        terraform 'terraform'
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
        stage('terraform init & plan'){
            steps{
                script{
                    sh 'terraform init'
                    sh 'terraform plan -out tfplan'
                    sh 'terraform apply --auto-approve tfplan'
                    
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
