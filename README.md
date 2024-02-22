# Terraform AWS Infrastructure Configuration

## Prerequisites

Before you begin, ensure you have the following:

1. **Terraform Installed:**
   - Install [Terraform](https://www.terraform.io/downloads.html) on your local machine.

2. **AWS Credentials:**
   - Configure your AWS account credentials on your machine.
     
3. **SSH Key Pair:**
   - Generate an SSH key pair using the following command:
     ```bash
     ssh-keygen -t rsa -b 2048 -f adityakeypair.pem
     ```
     This will generate `adityakeypair.pem` (private key) and `adityakeypair.pem.pub` (public key). The public key will be used in the keypair configuration.


## Configuration Explanation

### Provider Configuration
   - Set the AWS region in the provider block.

### VPC and Subnet Configuration
   - Define VPC settings with a specified CIDR block.
   - Create a subnet within the VPC, setting the CIDR block and availability zone.

### Internet Gateway and Route Table Configuration
   - Attach an Internet Gateway to the VPC.
   - Create a default route in the route table to the Internet Gateway.

### Security Group and Key Pair Configuration
   - Configure a security group allowing SSH from a specific IP and HTTP from any IP.
   - Create an AWS key pair for EC2 instance access.

### EC2 Instance Configuration
   - Launch an EC2 instance with specified AMI, instance type, subnet, security group, and key pair.
   - Use user data script to install and start an Apache web server and display "Hello" on the default webpage.

## Usage Steps

1. **Update Configurations:**
   - Review and update the configuration parameters in `main.tf` as needed.

2. **Terraform Initialization:**
   - Run `terraform init` to initialize the working directory.
   ![terra_init](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/2db49d97-0866-4622-ae7e-65a12714f83e)

3. **Terraform Plan:**
   - Run `terraform plan` to view the execution plan.
   ![terra_plan](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/60225d47-1ade-4626-bddb-2b9088b2c9dc)
   ![terra_plan1](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/f240f561-a6f8-4c4a-9c29-33d07657576f)

4. **Terraform Apply:**
   - Run `terraform apply` to create the AWS infrastructure.
   ![terra_apply](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/8229ab82-35b7-458f-8b5b-08c2b811f124)
   ![terra_apply1](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/ec4722a8-b6b0-4cb6-a3bc-0b1bb6acd04f)

5. **Access the EC2 Instance:**
   - Once the infrastructure is created, access the EC2 instance via the public IP.

6. **Terraform Destroy (Optional):**
   - Run `terraform destroy` to destroy the created infrastructure when no longer needed.

## AWS Console Verification

- After applying the Terraform configuration, verify the created resources in the AWS Management Console.
  - EC2
    
  ![ec2](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/5f5db385-595d-4d30-83cf-d56dce7a91de)

  - Security Group
    
  ![securitygrp](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/044c6b51-876c-4fb2-8638-e8dcfea09257)

  - VPC
    
  ![myvpc](https://github.com/adityajha28/Terraform_Assignment_2/assets/127980079/414a3827-2b5f-41f6-8765-f7c7f6ccfd6e)

## Additional Notes
- **Terraform Version:**
  - Make sure you are using a version of Terraform compatible with the configurations.

- **AWS Permissions:**
  - Ensure your AWS credentials have the necessary permissions to create and manage resources.

- **Security Considerations:**
  - Review and modify security group rules based on your specific requirements.

- **Key Pair Management:**
  - Keep your private key secure and manage key pairs responsibly.

- **User Data Script:**
  - Customize the user data script inside the EC2 instance configuration according to your application setup.
