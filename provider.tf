provider "aws"{
 region=var.aws_region
 profile="production"
 default_tags{
   tags={
      Name="hii-coder-org"
      Project="core-service"
     }
   
 } 
}
