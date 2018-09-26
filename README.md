# terraform-selenium-aws

Currently It will provision the selenium hub and node on AWS for a Centos machine (linux), similary it can be used to provision the ubuntu, fedora or windows machines.


## Prerequisite 
* make sure that you have installed terraform in your machine, you can follow steps mentioned on official site https://www.terraform.io/intro/getting-started/install.html
* You must have an account to AWS and should know access_key, secreat_key, VPC_id, Subnet_id (these are the parameters needed to passed to terraform input)


## How to use?
* #### Terraform init 

```
terraform init
provider.aws: version = "~> 1.31"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.


```
* #### Terraform plan 
```
terraform plan 

Plan: 6 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```



* #### Terraform Apply 

```
terraform apply

aws_instance.selenium_node_instance: Creation complete after 2m9s (ID: i-032adfe4d9ae553c9)

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

```

at this step we are almost done with provisioning selenium grid on AWS :)

## Running Selenium Grid Test 

* #### python -m unittest -v test.py


