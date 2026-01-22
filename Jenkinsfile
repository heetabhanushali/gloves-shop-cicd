pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Services') {
            parallel {
                stage('Web') {
                    steps {
                        sh 'docker build -t gloves-shop-web:${IMAGE_TAG} ./web'
                    }
                }
                stage('Cart') {
                    steps {
                        sh 'docker build -t gloves-shop-cart:${IMAGE_TAG} ./cart'
                    }
                }
                stage('Catalogue') {
                    steps {
                        sh 'docker build -t gloves-shop-catalogue:${IMAGE_TAG} ./catalogue'
                    }
                }
                stage('User') {
                    steps {
                        sh 'docker build -t gloves-shop-user:${IMAGE_TAG} ./user'
                    }
                }
                stage('Payment') {
                    steps {
                        sh 'docker build -t gloves-shop-payment:${IMAGE_TAG} ./payment'
                    }
                }
                stage('Shipping') {
                    steps {
                        sh 'docker build -t gloves-shop-shipping:${IMAGE_TAG} ./shipping'
                    }
                }
                stage('Ratings') {
                    steps {
                        sh 'docker build -t gloves-shop-ratings:${IMAGE_TAG} ./ratings'
                    }
                }
                stage('Dispatch') {
                    steps {
                        sh 'docker build -t gloves-shop-dispatch:${IMAGE_TAG} ./dispatch'
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
        
        stage('Security Scan') {
            steps {
                echo 'Running security scan...'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying to Kubernetes...'
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}