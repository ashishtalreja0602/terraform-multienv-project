locals {

  env_config = {
    
  dev = {
    instance_count = 2    
  }

  stage = {
    instance_count = 3
  }

  production = {
    instance_count = 3
  }
  }

  current_env = local.env_config[terraform.workspace]
  
}



module "ec2" {
    source = "./modules/ec2"
    env =  terraform.workspace
    ec2_instance_count = local.current_env.instance_count  
    
}