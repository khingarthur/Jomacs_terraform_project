OVERVIEW

    This Terraform project deploys a secure VPC environment in AWS with an EC2 instance running an Nginx web server. The EC2 instance resides within a private subnet and is accessible to the outside world via a load balancer. Traffic to the EC2 instance is routed through a NAT gateway.

PROJECT STRUCTURE

    Within this """"""" repo is a source directory and this ReadMe.md file.
    The source directory contains four sub directories, a Main directory, Modules directory and .githubactions directory.

    The Main directory is the root directory which contains all the individual
    resources used for this project.
    The Main directory which serves as the root of the project contains the following
    1. vpc.tf
    2. subnets.tf
    3. security_groups.tf
    4. ec2.tf
    5. outputs.tf
    6. variables.tf
    7. s3.tf
    8. main.tf
    9. provider.tf
    10. elb.tf
    11. keypair.tf
    12. gateway.tf
    13. store.tf
    14. script.sh

    The Module directory contain two sub directories VPC and EC2 which are two separate reusable modules
    Each module contains configuration files that are perculiar to the module.

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

HOW TO DEPLOY THE INFRASTRUCTURE

    An aws s3 bucket must first be created, This is because an S3 backend have been decleard where terraform state files will be stored. Else comment the backend configuration out.

    Fork or clone the repository to your local environment
    Move into the cloned repository,
    Change directory into the Main directory, which serves as the root directory for all configurations.
    Go through the code and modify it if neccessary
    Run terraform init, to initialize the terraform provider configuration
    Run terraform plan, and terraform apply to have the resources created.

STEPS TO VALIDATE THE SETUP
    To validate this setup, copy and paste the load balancer dns name that is outputed after your resources have been created into your browser.
    You should get a response Congratulating you for installing Nginix - just like the image below:
    NOTE: Wait for a while so the the ec2 instance initialises and the user data runs copletely.


