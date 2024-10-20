# Deploy a Simple Web Application on Kubernetes
This project demonstrates how to deploy a simple static web application using HTML/CSS, Docker, NGINX, and Kubernetes. The web app is containerized with Docker and deployed on a Kubernetes cluster, exposing it to users via a LoadBalancer service. This project highlights essential concepts in containerization, orchestration, and scalability, making it an excellent beginner-friendly introduction to cloud-native deployments.

## Tech Stack
#### HTML/CSS: Frontend for the static web application
#### NGINX: Web server to serve static content
#### Docker: Containerization platform
#### Kubernetes: Orchestration for managing containerized applications

## Project Features
#### A simple static website with an index.html and styles.css file
#### Containerized with NGINX using a lightweight Docker image
#### Kubernetes Deployment with multiple replicas for high availability
#### Exposed via a Kubernetes Service using a LoadBalancer
#### Scalable and ready for cloud deployment

## Steps to Deploy
#### Dockerize the static web application using a Dockerfile to package the site with NGINX.
#### Build and push the Docker image to Docker Hub (or any container registry).
#### Create a Kubernetes Deployment to manage the container replicas.
#### Expose the deployment using a Kubernetes Service.
#### Test the application by accessing it through the Service's external IP or URL.

## Learning Outcomes
#### Understanding the basics of Docker and containerization
#### Working with NGINX as a web server inside a Docker container
#### Deploying containerized applications on a Kubernetes cluster
#### Managing replicas and scaling applications in Kubernetes
#### Exposing applications with Kubernetes Services (LoadBalancer)

![Kubernetes Architecture Diagram](https://github.com/SrilekhaS20/static-website/blob/main/images/Kubernetes_diagram.drawio.png)
