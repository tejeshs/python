FROM jenkins/jenkins:latest
USER root
RUN apt update -y
RUN apt install docker.io -y
RUN apt install awscli -y
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

