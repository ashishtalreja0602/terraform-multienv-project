variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-east-2"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0d76b909de1a0595d"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t2.micro", "t2.small", "t2.medium", "t3.micro", "t3.small", "t3.medium"], var.instance_type)
    error_message = "Instance type must be one of: t2.micro, t2.small, t2.medium, t3.micro, t3.small, t3.medium."
  }
}

variable "env" {
  description = "Deployment environment (dev, staging, prd)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prd"], var.env)
    error_message = "Environment must be one of: dev, staging, prd."
  }
}

variable security-grooup{
     default = "terraform-security-group" 
     type= string
     description = "This value hold the name of the terraform group."  
} 

variable ec2_instance_count{
     default = 3
    type = number
    description = "This variable hold the value of the ec2 instance"
}

variable instance_name{
     default = "env-nulti-env-instance"
    type = string
    description = "This variable hold the value of the ec2 instance"

}
