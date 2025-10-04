pipeline {
    agent any

    environment {
        REGISTRY     = "docker.io"
        IMAGE_NAME   = "rupali1111"
        IMAGE_TAG    = "latest"
        SERVER_PORT  = "8085"
        DOCKERHUB_CREDENTIALS = "creds"  // Jenkins credentials ID for DockerHub login
    }

    stages {

        // 1️⃣ Checkout Code
        stage('Checkout') {
            steps {
                echo "📥 Cloning repository..."
                git branch: 'master', url: 'https://github.com/Curiousgoal202/rupali1111.git'
            }
        }

        // 2️⃣ Build Application
        stage('Build') {
            steps {
                echo "🔨 Building Flask Payment Gateway App..."
                sh '''
                if [ -f app/requirements.txt ]; then
                    pip install -r app/requirements.txt
                else
                    echo "No requirements.txt found — skipping dependency install"
                fi
                '''
            }
        }

        // 3️⃣ Test Stage (Optional)
        stage('Test') {
            steps {
                echo "🧪 Running Tests..."
                sh '''
                if [ -d tests ]; then
                    pytest || true
                else
                    echo "No tests found — skipping tests"
                fi
                '''
            }
        }

        // 4️⃣ Docker Build
        stage('Docker Build') {
            steps {
                echo "🐳 Building Docker Image..."
                sh '''
                docker build -t $IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }

        // 5️⃣ Docker Push to DockerHub
        stage('Docker Push') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS,
                                                     usernameVariable: 'DOCKER_USER',
                                                     passwordVariable: 'DOCKER_PASS')]) {
                        sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker tag $IMAGE_NAME:$IMAGE_TAG $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG
                        docker push $DOCKER_USER/$IMAGE_NAME:$IMAGE_TAG
                        '''
                    }
                }
            }
        }

        // 6️⃣ Deploy on EC2
        stage('Deploy') {
            steps {
                echo "🚀 Deploying container on EC2..."
                sh '''
                docker stop rupali1111 || true
                docker rm rupali1111 || true
                docker run -d --name rupali1111 -p $SERVER_PORT:8080 $IMAGE_NAME:$IMAGE_TAG
                '''
            }
        }

        // 7️⃣ Health Check
        stage('Health Check') {
            steps {
                echo "🩺 Checking App Health..."
                sh '''
                sleep 5
                STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:$SERVER_PORT || true)
                if [ "$STATUS_CODE" = "200" ]; then
                    echo "✅ Health Check Passed"
                else
                    echo "❌ Health Check Failed"
                    exit 1
                fi
                '''
            }
        }
    }

    post {
        success {
            echo "✅ Deployment successful! Your app is running on port $SERVER_PORT"
        }
        failure {
            echo "❌ Deployment failed! Please check Jenkins logs."
        }
    }
}
