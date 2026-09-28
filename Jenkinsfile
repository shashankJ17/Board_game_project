pipeline {
    agent any
   
    tools{
        jdk 'JAVA_HOME'
        maven 'MAVEN_HOME'
        dockerTool 'DOCKER_HOME'
    }
    environment{
        AWS_REGION = "ap-south-1"
        CLUSTER_NAME = "SXeks-cluster"
        DOCKER_IMAGE = "shashankj017/boardgame-image:v1"
    }
    
    stages {
        stage('Cloning BoardGame project') {
            steps {
                git branch: 'master', url: ''
            }
        }
        
         stage('Compile BoardGame project') {
            steps {
                sh 'mvn compile'
            }
        }
        
        stage('Test Source code of BoardGame project') {
            steps {
                sh 'mvn test'
            }
        }
        
         stage('Scanning Source code of BoardGame project using Sonarqube') {
            steps {
                withSonarQubeEnv('Sonarqube') {
                    // some block
                    sh 'mvn verify sonar:sonar -Dsonar.projectName=boardgame -Dsonar.projectKey=boardgame'
                }
            }
        }
        
        stage('Generating Package for Source code of BoardGame project') {
            steps {
                sh 'mvn package'
            }
        }
        
        stage('Deploy Source code of BoardGame project into Nexus') {
            steps {
                withMaven(globalMavenSettingsConfig: 'Nexus-ID', jdk: 'JAVA_HOME', maven: 'MAVEN_HOME', traceability: true) {
                        // some block
                        sh 'mvn clean deploy'
                }
            }
        }
        
         stage('Generating Image for BoardGame project using Docker') {
            steps {
                // This step should not normally be used in your script. Consult the inline help for details.
               withDockerRegistry(credentialsId: 'Docker-credentials', url: 'https://index.docker.io/v1/') {
                    // some block
                    sh 'docker build -t shashankj017/boardgame-image:v1 .'
                }
            }
        }
        
        stage('Scanning BoardGame-Image via Trivy') {
            steps {
                sh 'TMPDIR=/tmp-trivy trivy image --format table shashankj017/boardgame-image:v1'
            }
        }
        
        stage('Pushing Image of BoardGame project to DockerHub') {
            steps {
               // This step should not normally be used in your script. Consult the inline help for details.
                    withDockerRegistry(credentialsId: 'Docker-credentials', url: 'https://index.docker.io/v1/') {
                        // some block
                        sh 'docker push shashankj017/boardgame-image:v1'
                }
            }
        }
        
        stage('Deploying the application into a eks cluster') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'ap-south-1') {
                    // Double quotes """ are REQUIRED here to evaluate variables
                    sh """
                        echo "Updating image name in deployment-service.yaml..."
                        sed -i "s|_IMAGE_NAME_|${DOCKER_IMAGE}|g" deployment-service.yaml
                        
                        echo "Configuring kubectl for EKS cluster..."
                        aws eks --region ${AWS_REGION} update-kubeconfig --name ${CLUSTER_NAME}
                        
                        echo "Applying deployment to EKS..."
                        kubectl apply -f deployment-service.yaml
                    """
                }
            }
        }
    }
    
    post {
        success {
            mail(
                bcc: '',
                body: 'This mail is to notify that the build is successful.',
                cc: 'shashankjayram2004@gmail.com',
                from: '',
                replyTo: '',
                subject: 'Build Successful',
                to: 'shashankjayram2004@gmail.com'
            )
        }

        failure {
            mail(
                bcc: '',
                body: 'This mail is to notify that the build has failed.',
                cc: 'shashankjayram2004@gmail.com',
                from: '',
                replyTo: '',
                subject: 'Build Failed',
                to: 'shashankjayram2004@gmail.com'
              )
             }
             
       
    }
}