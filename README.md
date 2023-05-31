# ITI-project-infra
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ### - Implement and configure secure Kubernetes cluster on AWS using infrastructure as a code (IaC),
 ### - Deploy and configure Jenkins on the created K8s cluster
 ### - Use seperate nemaspace for Jenkins's deployment on K8s
 ### - create Jenkins pipeline to trigger the deployment of the backend application
 
![image](https://github.com/MahaElomey/Full-CI-CD-project-infra/assets/47718954/caf3b54f-ec69-415f-b8b9-b7e9101cca76)


## Tools Used
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- Terraform
- Amazon Web Service (AWS)
- Kubernetes
- Docker Platform
- Ansible
- Jenkins
- 

## Steps
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
- Create Dockerfile for a simple web app (microo) 
- Create kubernetes resources needed to deploy the application
- Create infrastructure using Terraform to deploy private K8s in AWS
- Use ansible to configure bastion Host to access K8s
- Use ansible to deploy Jenkins resources
- Configure Jenkins to use bastion host as a slave
- Create jenkins pipline to Build the appplication Dockerfile and push it to dockerhub repository, then Deploy the application in kubernetes cluster as deployment using this aploaded image
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Please check the web application (microo) files in the folowing repo:
``` sh
https://github.com/MahaElomey/ITI-project-app.git
```
## Deployment steps :
1- clone the project
```sh
git clone https://github.com/MahaElomey/Full-CI-CD-ITI-project-infra.git
```
2- Run terraform init to initializes a Terraform working directory after you setup S3 bucket
```sh
terraform init
```
3- Run terraform apply to deploy the infrastructure resources with variables file
```sh
sudo terraform apply --var-file dev.tfvars
```
4- Run ansible playbook to configur the bastion host and deploy jenkins resources
```sh
ansible-playbook -i inventory jenkins.yaml
```
#### Congratulations you deploy a Jenkins :)

5- install the recommended plugins, and then Create your admin user

![image](https://github.com/MahaElomey/Full-CI-CD-ITI-project-infra/assets/47718954/c7a1b292-2ccd-4af3-a4c4-ec2ae03f9a29)

6- Create slave SSH credintial to deploy our application on it

![image](https://github.com/MahaElomey/Full-CI-CD-ITI-project-infra/assets/47718954/2f970394-7310-4720-b493-8892a78b2d04)

7- Add webhook to your application repo to trigger the pipeline

![image](https://github.com/MahaElomey/Full-CI-CD-ITI-project-infra/assets/47718954/e19bd7b4-e42b-49e5-b661-fb925cb91ad6)

![image](https://github.com/MahaElomey/Full-CI-CD-ITI-project-infra/assets/47718954/3d60b2bb-aea8-4012-a152-093a7e11997e)

8- finalllllly we deploy our application (microo)



https://github.com/MahaElomey/Full-CI-CD-ITI-project-infra/assets/47718954/a3435cb6-ead2-46b7-95ba-06c4f4cdeeb1



