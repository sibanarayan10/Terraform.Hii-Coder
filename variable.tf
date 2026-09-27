variable "aws_region"{
 type:string
 default="ap-south-1"
 description="It describe the region of the machine that we are going to create"
 validation{
  condition=(["us-east-1","ao-south-1"],var.aws_region)
  error_message="Invalid region"
 }
}

variable "aws_instance_type"{
 type:string
 default="t1.micro"
 description="It describe the region of the machine that we are going to create"
 validation{
  condition=(["t1.micro","t2.micro","t2.small"],var.aws_instance_type)
  error_message="Invalid instance type"
 }
}

variable "aws_provider_profile"{
 type:string
 default="dev"
 description="It describe the region of the machine that we are going to create"
 validation{
  condition=(["dev","stage","production"],var.aws_provider_profile)
  error_message="Invalid provider profile"
 }
}


variable "aws_enviroment"{
 type:string
 default="dev"
 description="It describe the region of the machine that we are going to create"
 validation{
  condition=(["dev","stage","production"],var.aws_enviroment)
  error_message="Invalid provider profile"
 }
}

variable "project"{
 type:string
 default="core-service"
 description="It describe the region of the machine that we are going to create"
 validation{
  condition=(["core-service","submission-service"],var.project)
  error_message="Invalid project name"
 }
}
