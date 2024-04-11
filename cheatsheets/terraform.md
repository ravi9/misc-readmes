
# Terraform Basics
- Terraform: Infrastructure as Code (IaC) tool for provisioning and managing 
  resources across various cloud providers and services
- HCL: HashiCorp Configuration Language, the language used to write 
  Terraform configurations
- Provider: A plugin that enables Terraform to interact with a specific 
  cloud provider or service (e.g., AWS, GCP, Azure)
- Resource: An object managed by Terraform, representing an infrastructure 
  component (e.g., VM, database, network)
- Module: A reusable package of Terraform configurations that encapsulates a 
  set of resources and their dependencies

# Terraform Commands
```
terraform init      # Initialize a Terraform working directory
terraform plan      # Create an execution plan, showing the changes to be made to the infrastructure
terraform apply     # Apply the changes described in the Terraform configuration
terraform destroy   # Destroy the resources managed by Terraform
terraform validate  # Validate the syntax and configuration of Terraform files
terraform fmt       # Format Terraform configuration files for readability and consistency
terraform import    # Import existing resources into Terraform state
terraform output    # Display output values from a Terraform state
terraform state     # Manage the Terraform state file
terraform workspace # Manage Terraform workspaces for environment isolation
```
# Terraform Configuration
- Use variables to parameterize your configuration and make it reusable
- Use locals to assign a name to an expression and reuse it throughout the configuration
- Use data sources to fetch information from external sources and use it in your configuration
- Use provisioners sparingly, prefer using configuration management tools for post-deployment tasks
- Use modules to encapsulate and reuse common configurations
- Use workspaces to manage multiple environments (e.g., dev, staging, prod) within the same configuration

# Best Practices
- Write modular and reusable configurations
- Use meaningful names for resources, variables, and modules
- Use variables to make your configuration more flexible and customizable
- Use a consistent naming convention and structure for your Terraform files
- Use a version control system (e.g., Git) to manage your Terraform configurations
- Use a remote backend (e.g., Terraform Cloud, S3) to store the Terraform state file securely
- Use Terraform workspaces to manage multiple environments
- Use Terraform modules to encapsulate and reuse common configurations
- Regularly run `terraform plan` to preview changes before applying them
- Use `terraform fmt` to maintain consistent formatting and readability
- Use `terraform validate` to catch syntax errors and configuration issues early

# Tips and Tricks
- Use `terraform graph` to visualize the dependency graph of your resources
- Use `terraform plan -out=plan.out` to save a plan file for later execution
- Use `terraform apply -auto-approve` to apply changes without manual confirmation (use with caution)
- Use `terraform import` to bring existing resources under Terraform management
- Use `terraform state mv` to refactor and reorganize your Terraform state
- Use `terraform workspace` to manage multiple environments within the same configuration
- Use `terraform output` to display important information (e.g., IP addresses, URLs) after applying changes
- Use `terraform taint` to mark a resource for recreation in the next `terraform apply`
- Use `terraform untaint` to remove the taint marker from a resource
- Use `terraform state pull > state.json` to backup your Terraform state file

# Don'ts
- Don't commit sensitive information (e.g., credentials, secrets) to version control
- Don't modify the Terraform state file manually, use `terraform state` commands instead
- Don't use `terraform apply` without first running `terraform plan` and reviewing the changes
- Don't use `terraform destroy` without careful consideration and backup of important data
- Don't use `terraform workspace` for sensitive or production environments without proper access controls
