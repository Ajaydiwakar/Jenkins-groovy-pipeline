# demo-project  This is the Jenkins Groovy script .Need to be placed under the jenkins job - pipeline script


node{
    stage("Pull source code from github"){
        git branch: 'main', url: 'https://github.com/Ajaydiwakar/demo-project.git'
     }
    stage("Build Docker file"){
         sh 'docker image build -t $JOB_NAME:v1.$BUILD_ID .'
         sh 'docker image tag $JOB_NAME:v1.$BUILD_ID ajay44/$JOB_NAME:v1.$BUILD_ID'
         sh 'docker image tag $JOB_NAME:v1.$BUILD_ID ajay44/$JOB_NAME:latest' 
     }
    stage(" Pushing the image to docker hub " ){
         withCredentials([string(credentialsId: 'dockerhubpassword', variable: 'dockerhubpassword')]) {
    // some block
           
          sh 'docker login -u ajay44 -p  ${dockerhubpassword}'
          sh 'docker image push ajay44/$JOB_NAME:v1.$BUILD_ID'            
          sh 'docker image push ajay44/$JOB_NAME:latest'
          sh 'docker image rmi $JOB_NAME:v1.$BUILD_ID  ajay44/$JOB_NAME:v1.$BUILD_ID  ajay44/$JOB_NAME:latest tail -f /dev/null'
          }
    }
    stage(" Deployment of docker container on Docker host"){
    def dockerrm  = 'docker container rm -f ajaydiwakar'
    def dockerrun = 'docker container run -p 8080:80 -d --name ajaydiwakar ajay44/scripted-pipeline-demo tail -f /dev/null'
    def docker_image = ' docker image rmi -f ajay44/scripted-pipeline-demo'
    sshagent(['dockerhostpassword']) {
    // some block
    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.31.27 ${dockerrm}"
    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.31.27 ${docker_image}"
    sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.31.27 ${dockerrun}"
    
}
}
    
         
}
