#Imagem do ubuntu
FROM ubuntu:latest

#Mantenedor do Dockerfile
LABEL maintainer="Arthur"

#Atualização de pacotes e dependências necessárias
RUN apt-get update && \
    apt-get install -y wget unzip curl openssh-client iputils-ping pgnupg lsb-release

#Versão do terraform
ENV TERRAFORM_VERSION=1.7.0

#Baixar e instalar terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#Criar a pasta /iac como ponto de montagem para um volume
RUN mkdir /lab1
VOLUME /lab1

#Adicionar repo do GCloud SDK e instalar
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -- && \
    apt-get update && apt-get install -y google-cloud-sdk

#Definir o comando padrão do container
CMD ["/bin/bash"]