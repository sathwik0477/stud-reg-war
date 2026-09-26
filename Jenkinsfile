pipeline {
    agent any
    stages {
        stage('--clean--') {
            steps {
                sh 'mvn clean'
            }
        }
        stage('--compile--') {
            steps {
                sh 'mvn compile'
            }
        }
        stage('--test--') {
            steps {
                sh 'mvn test'
            }
        }
        stage('--package--') {
            steps {
                sh 'mvn package'
            }
        }
        stage('--install--') {
            steps {
                sh 'mvn install'
            }
        }
	stage('--add settings.xml to .m2--') {
	    steps {
		sh "cp settings.xml /var/lib/jenkins/.m2/settings.xml"
	    }
	}
        stage('--deploy to Nexus--') {
            steps {
                sh 'mvn deploy'
            }
        }
        stage('--deploy to Tomcat--') {
            steps {
                sh "cp /var/lib/jenkins/.m2/repository/com/example/stud-reg-war/0.0.1-SNAPSHOT/stud-reg-war-0.0.1-SNAPSHOT.war /var/lib/tomcat10/webapps/student-app.war"
            }
        }
    }
}

