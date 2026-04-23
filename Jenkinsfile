pipeline {
    agent any 
    
    tools{
        jdk 'jdk11'
        maven 'maven3'
    }
    
    environment {
        SCANNER_HOME=tool 'sonarqube'
    }
    
    stages{
        
        stage("Git Checkout"){
            steps{
                git branch: 'main', changelog: false, credentialsId: 'github', poll: false, url: 'https://github.com/mohit789123/penclinic-pipeline.git'
            }
        }
        stage("mvn clean"){
            steps{
                sh("mvn clean -DskipTest package")
            }
        }
        
       stage("SonarQube-Analysis"){
         steps{
             withSonarQubeEnv('sonarqube') {
    
sh '''
               mvn clean verify sonar:sonar \
               -Dsonar.projectKey=petclinic \
               -Dsonar.projectName=petclinic \
               -Dsonar.java.binaries=target/classes
            '''
             }
         }
      }
      stage("OWASP Dependency Check"){
         steps{
            dependencyCheck additionalArguments: '--scan ./ --format HTML', odcInstallation: 'DP'
            dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
         }
      }
      stage("Build"){
            steps{
                sh (" mvn clean install")
            }
        }
        stage("Docker Build and Push"){
          steps{
                  sh 'docker login -u dockerm17 -p password@2001'
                  sh 'docker build -t petclinic .'
                  sh 'docker tag petclinic dockerm17/petclinic-repo:petclinic'
                  sh 'docker push dockerm17/petclinic-repo:petclinic'
                  } 
            }
     stage('Deploy To Tomcat Container') {
    steps {
        
        sh 'docker rm -f petclinic || true'
        sh 'docker run -d --name petclinic -p 8081:8080 dockerm17/petclinic-repo:petclinic'
       }
    }
  }
}

