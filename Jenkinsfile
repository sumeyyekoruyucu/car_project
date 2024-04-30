pipeline {
    agent any
    parameters {
        string(name: 'USERNAME', defaultValue: 'sumeyye-koruyucu', description: 'Enter your username')
        choice(name: 'WORKSPACE', choices: ['dev', 'test', 'prod','staging'], description: 'Please Select a Workspace')
        string(name: 'AMI_ID', choices: ['ami-06640050dc3f556bb', 'ami-08d4ac5b634553e16'], description: "AMI ID ${params.WORKSPACE}")
        string(name: 'INSTANCE_TYPE', choices: ['t3a.medium', 't2.micro'], description: "INSTANCE_TYPE ${params.WORKSPACE}")
    }
   
    stages {
        stage('Example') {
            steps {
                echo "Hello, ${params.USERNAME}! You selected ${params.WORKSPACE}."
            }
        }

        stage('Deploy to AWS') {
            steps {
                echo "Deploying using AMI ID ${params.AMI_ID} and instance type ${params.INSTANCE_TYPE}"
            }
        }

        stage('Create Key Pair for car_project') {
            steps {
                echo "Creating Key Pair for ${APP_NAME} App"
                sh "aws ec2 create-key-pair --region ${AWS_REGION} --key-name ${AWS_KEYPAIR} --query KeyMaterial --output text > ${AWS_KEYPAIR}"
                sh "chmod 400 ${AWS_KEYPAIR}"
            }
        }

        stage('Create Infrastructure for the App') {
            steps {
                echo 'Creating Infrastructure for the App on AWS Cloud'
                sh 'terraform init'
                sh 'terraform apply --auto-approve'
            }
        }
    }

    environment {
        PATH=sh(script:"echo $PATH:/usr/local/bin", returnStdout:true).trim()
        AWS_REGION = "us-east-1"
        AWS_KEYPAIR="car-project"
        AWS_ACCOUNT_ID=sh(script:'export PATH="$PATH:/usr/local/bin" && aws sts get-caller-identity --query Account --output text', returnStdout:true).trim()
        APP_NAME = "Car"
    }
}
