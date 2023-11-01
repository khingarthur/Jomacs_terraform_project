<h1> JOMACS TERRAFORM PROJECT <h1>

<h2>Author : Frederick Arthur<h2>
<h2>Date : 31/10/2023<h2>

<h2>OBJECTIVES<h2>

This Terraform project deploys a secure VPC environment in AWS with an EC2 instance running an Nginx web server. The EC2 instance resides within a private subnet and is accessible to the outside world via a load balancer. Traffic to the EC2 instance is routed through a NAT gateway.

<h2>PROJECT STRUCTURE<h2

    Within this Jomacs terraform project are three directories
   * .github repo
   * Main repo
   * Modules


    The Main directory is the root directory, which contains all the individual
    resources used for this project.
    The Main directory which serves as the root of the project contains the following
    1. vpc.tf
    2. subnets.tf
    3. security_groups.tf
    4. ec2.tf
    5. outputs.tf
    6. variables.tf
    7. main.tf
    8. provider.tf
    9. elb.tf
    10. gateway.tf
    11. store.tf
    12. script.sh

    The Module directory contain two sub directories VPC and EC2 which are two separate reusable modules. Each module contains configuration files that are perculiar to the module.

    The VPC directory contains
    1. main.tf
    2. output.tf
    3. variables.tf
    4. provider.tf
    5. store.tf

    The EC2 directory contains
    1. main.tf
    2. output.tf
    3. variables.tf
    4. provider.tf
    5. data.tf
    6. script.sh
    
    The .githubactions directory contains workflow in a yml file for automating the deployement process using GitHub actions.

<h2>ASSUMPTIONS<h2>

1. This project include a backend configuration where state files are stored for security reasons. It is therefore assumed that an s3 bucket already exist for that. If not, comment out the backend configuration in the provider.tf to avoid errors when applying.

2. It is assumed that the keypair attached to the ec2 instance already exist. So the keyname in the ec2 configuration must reference that. If not then comment out the keyname section
    

<h2>HOW TO DEPLOY THE INFRASTRUCTURE<h2>

    An aws s3 bucket must first be created, This is because an S3 backend have been decleard where terraform state files will be stored. Else comment the backend configuration out.

    Fork or clone the repository to your local environment
    Move into the cloned repository,
    Change directory into the Main directory, which serves as the root directory for all configurations.
    Go through the code and modify it if neccessary

    There are two ways for deploying the infrastructure

    1. Automation
    Push the "Main" directory to your github account, deployement of the infrastructure begins auto,atically.
    

    2. Manual 
    Run terraform init, to initialize the terraform provider configuration
    Run terraform plan, and terraform apply to have the resources created.

<h2>STEPS TO VALIDATE THE SETUP<h2>
    To validate this setup, copy and paste the load balancer dns name that is outputed after your resources have been created into your browser.
    You should get a response "JOMACS Terraform Project To Install Nginx Complete"
    
    NOTE: Wait for a while so the the ec2 instance initialises and the user data runs copletely.

    
