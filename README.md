# 🚀 Static Website Deployment with Docker, NGINX & Kubernetes

> **Live Demo:** [🌐 Visit Live Site](https://srilekhas20.github.io/static-website/) 
[![Dockerized](https://img.shields.io/badge/Dockerized-Yes-blue)](https://www.docker.com/)
[![Built with NGINX](https://img.shields.io/badge/Web--Server-NGINX-brightgreen)](https://nginx.org/)
[![CI/CD Ready](https://img.shields.io/badge/CI%2FCD-Jenkins-blueviolet)](https://jenkins.io/)
[![Kubernetes](https://img.shields.io/badge/Deployed%20On-Kubernetes-326ce5)](https://kubernetes.io/)
[![Project Status](https://img.shields.io/badge/Status-Completed-success)](#)

## 🧠 Why This Project?

I built this project to showcase a real-world DevOps use case—containerizing a static website, deploying it with NGINX on Docker, and orchestrating it through Kubernetes. It demonstrates my understanding of automation, scalability, and modern infrastructure practices—skills essential for cloud-native environments and fast-paced product teams.

> A beginner-friendly DevOps project that demonstrates how to containerize and deploy a static web application using **Docker**, **NGINX**, and **Kubernetes**, highlighting real-world cloud-native practices.

---

## 📌 Table of Contents
- [🛠️ Tech Stack](#️-tech-stack)
- [📦 Project Structure](#-project-structure)
- [🚀 Deployment Steps](#-deployment-steps)
- [📸 Preview](#-preview)
- [🎯 Why This Project Matters](#-why-this-project-matters)
- [🧠 Learning Outcomes](#-learning-outcomes)
- [🔧 My Role](#-my-role)
- [🛤️ Future Improvements](#-future-improvements)

---

## 🛠️ Tech Stack

| Tool         | Purpose                             |
|--------------|-------------------------------------|
| HTML/CSS     | Static frontend website             |
| NGINX        | Web server for static content       |
| Docker       | Containerization                    |
| Kubernetes   | Container orchestration             |
| Jenkins      | (Optional) CI/CD pipeline setup     |

---

## 📦 Project Structure
```
.
├── index.html
├── styles.css
├── Dockerfile
├── k8s
│   ├── deployment.yaml
│   └── service.yaml
└── images
    └── Kubernetes_diagram.drawio.png
```

---

## 🚀 Deployment Steps

1. **Dockerize the App**
   ```bash
   docker build -t sri24devops/static-website .
   docker run -d -p 8080:80 sri24devops/static-website
   docker push sri24devops/static-website

2. **Apply Kubernetes Manifests**
    ```bash
    kubectl apply -f k8s/deployment.yaml

3. **Access the app**
 ##### If using Minikube:
    ```bash
    minikube service static-site-service
  ##### In cloud: Visit the LoadBalancer external IP
    ``` bash
    kubectl apply -f k8s/service.yaml

## 🎯 Why This Project Matters
##### Deploying even a simple static website using Kubernetes introduces critical DevOps skills:

##### Container image creation and optimization

##### Orchestrating services and replicas

##### High availability and scalability

##### Load balancing and networking in Kubernetes

##### This is the foundation of what happens behind the scenes in most cloud-native production environments.

## 🧠 Learning Outcomes
##### 🐳 Dockerfile creation and image publishing

##### ⚙️ Running NGINX inside a container

##### ☸️ Creating deployments and services in Kubernetes

##### 🔄 Managing stateless workloads and scaling

##### 📶 LoadBalancer & networking fundamentals

## 🔧 My Role
##### Designed and coded the frontend using HTML/CSS

##### Dockerized the app using a custom Dockerfile

##### Deployed the app on a local Kubernetes cluster

##### Configured Deployment and Service YAMLs

##### Managed replica sets for high availability

## 🛤️ Future Improvements
##### Add CI/CD pipeline using GitHub Actions or Jenkins

##### Enable HTTPS with cert-manager and Ingress

##### Host live version on GitHub Pages or cloud provider

##### Monitor pods using Prometheus & Grafana

## 🙌 Connect with Me
##### If you’re a recruiter or hiring manager looking for someone with hands-on DevOps experience and a passion for building scalable, automated infrastructure — let’s connect!

##### 📫 lekhaconst.1@gmail.com
##### 🔗 [LinkedIn](https://www.linkedin.com/in/srilekha-senthilkumar/)
##### 🐙 [GitHub](https://github.com/SrilekhaS20)

##### ⭐️ If you found this project helpful, feel free to star it and check out my other DevOps projects!
