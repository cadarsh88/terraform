# **Terraform Code that creates RDS Aurora global database Cross-Region on AWS**


## **Summary**

Configuration in this directory creates set of RDS resources including RDS Aurora global database Cluster Cross-Region (Encryption using KMS Keys).
Data sources are used to discover existing VPC resources (VPC, subnet and security group).

You can also enable cloudwatch logs and backup configuration settings.

## **Usage**

### **Work Flow for code execution in this repo:**

**Step 1 :** Clone the repo down locally 

```•	git clone https://git.sami.int.thomsonreuters.com/COE-DB-TF-Pattern-Library/tf-aws-rds-aurora-global.git```

**Step 2 :**  Create a branch from master

```•	git checkout -b  <branch name>```

**Step 3 :**  Use cloud-tool-fr to set your AWS configuration
 
```•	cloud-tool-fr login -u "mgmt\<Your_M_account>" -p "<Your_M_account_password>"  --region < aws region>```

**Step 4 :**  Review the Code *main.tf* in root folder and *tfvars* config


**Step 5 :**  Initialise your Terraform working directory

```•	terraform init``` 

**Step 6 :**  Run a terraform refresh to see what already exists

```•	terraform refresh --var-file=env/dev.tfvars```

Make sure the secrets already exists or create one on console or using awscli

**Step 7 :**  Run a terraform  plan to see what will be deployed

```•	terraform plan --var-file=env/dev.tfvars```

**Step 8 :**  Run a terraform apply to create the infrastructure

```•	terraform apply --var-file=env/dev.tfvars```


You can customize the tfvars file to choose RDS type, Engine , RDS Size,Engine Mode etc 

**Database password**

For security purposes, we are storing the database password as a secret key using Secret Manager,  using this module, you must set the database password using an environment variable (do not store the password value in Git)

**Database name**

You must conform to the database naming standards for the database you are using. For example, for a postgresql database, your database name must only include alphanumeric characters

**Note that this example may create resources which cost money. Run terraform destroy when you don't need these resources.**

## **Providers**

|Name|	Version|
|----|:--------:|
|AWS|	~> 2.0|


## **Inputs**


<table>
<tbody>
<tr>
<td >
<p><strong>Name</strong></p>
</td>
<td >
<p><strong>Description</strong></p>
</td>
</tr>
<tr>
<td >
<p>asset_id</p>
</td>
<td >
<p>Refintiv asset ID</p>
</td>
</tr>
<tr>
<td >
<p>rds_name</p>
</td>
<td >
<p>String to contain in the RDS name</p>
</td>
</tr>
<tr>
<td >
<p>rds_tags</p>
</td>
<td >
<p>Additional Tags to be applied to the RDS instance</p>
</td>
</tr>
<tr>
<td >
<p>rds_ingress</p>
</td>
<td >
<p>Inbound rules for RDS</p>
</td>
</tr>
<tr>
<td >
<p>rds_subnet_group_name</p>
</td>
<td >
<p>Name of existing subnet group to use</p>
</td>
</tr>
<tr>
<td >
<p>rds_vpc_security_group_ids</p>
</td>
<td >
<p>RDS List of VPC security groups to associate</p>
</td>
</tr>
<tr>
<td >
<p>rds_is_multi_az</p>
</td>
<td >
<p>Specifies if the RDS instance is multi-AZ</p>
</td>
</tr>
<tr>
<td >
<p>rds_engine</p>
</td>
<td >
<p>Engine to use in the RDS cluster</p>
</td>
</tr>
<tr>
<tr>
<td >
<p>engine_mode</p>
</td>
<td >
<p>The database engine mode. Valid values: global, parallelquery, provisioned, serverless.</p>
</td>
</tr>
<tr>
<td >
<p>rds_engine_family</p>
</td>
<td >
<p>Engine family to use in the RDS cluster</p>
</td>
</tr>
<tr>
<td >
<p>rds_engine_version</p>
</td>
<td >
<p>Version of the engine to use in the RDS cluster</p>
</td>
</tr>
<tr>
<td >
<p>rds_master_username</p>
</td>
<td >
<p>Master username for the database</p>
</td>
</tr>
<tr>
<td >
<p>rds_master_password_secret_name</p>
</td>
<td >
<p>Name of the secret holding the rds master password. This secret must be set manually in the AWS console using AWS Secrets Manager. The secret name must start with the asset ID</p>
</td>
</tr>
<tr>
<td >
<p>rds_allocated_storage</p>
</td>
<td >
<p>RDS allocated storage</p>
</td>
</tr>
<tr>
<td >
<p>rds_backup_retention_period</p>
</td>
<td >
<p>Backup retention period in days</p>
</td>
</tr>
<tr>
<td >
<p>rds_backup_window</p>
</td>
<td >
<p>Preferred backup window for automated backups</p>
</td>
</tr>
<tr>
<td >
<p>rds_snapshot_identifier</p>
</td>
<td >
<p>The snapshot identifier used when restoring from backup. Default is null. Only set this value if restoring from backup</p>
</td>
</tr>
<tr>
<td >
<p>rds_instance_count</p>
</td>
<td >
<p>Amount of instances to put into the RDS cluster</p>
</td>
</tr>
<tr>
<td >
<p>rds_instance_type</p>
</td>
<td >
<p>Size of the RDS instance to use</p>
</td>
</tr>
<tr>
<td >
<p>region</p>
</td>
<td >
<p>The AWS region</p>
</td>
</tr>
<tr>
<td >
<p>vpc_id</p>
</td>
<td >
<p>VPC ID to be used in the region</p>
</td>
</tr>
<tr>
<td >
<p>database_name</p>
</td>
<td >
<p>The name of the default database that will be created</p>
</td>
</tr>
<tr>
<td >
<p>storage_encrypted</p>
</td>
<td >
<p>Specifies whether the RDS DB cluster is encrypted. The default is set to true to comply with Refinitiv standards</p>
</td>
</tr>
<tr>
<td >
<p>skip_final_snapshot</p>
</td>
<td >
<p>whether we should skip taking a snapshot of db before destroying it</p>
</td>
</tr>
<tr>
<td >
<p>enabled_cloudwatch_logs_exports</p>
</td>
<td >
<p>List of log types to export to cloudwatch. If omitted. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)</p>
</td>
</tr>
<tr>
<td >
<p>fr_application_asset_insight_id</p>
</td>
<td >
<p>To populate mandatory tr:application-asset-insight-id tag. See</p>
<p><a href="https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards">https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards</a></p>
</td>
</tr>
<tr>
<td >
<p>fr_environment_type</p>
</td>
<td >
<p>To populate mandatory fr:environment-type tag. See <a href="https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards">https://confluence.refinitiv.com/display/PCP/Standard%3A+Cloud+Service+Provider+Naming+and+Tagging+Standards</a></p>
</td>
</tr>
<tr>
<td >
<p>fr_resource_owner</p>
</td>
<td >
<p>Tag your own email ID</p>
</td>
</tr>
<tr>
<td >
<p>rds_apply_changes_immediately</p>
</td>
<td >
<p>Specify whether any database modifications are applied immediately, or during the next maintenance window.</p>
</td>
</tr>
<tr>
<td >
<p>rds_security_group_identifier</p>
</td>
<td >
<p>The string to be appended to the name of the security group. This allows for multiple RDS instances to be created in the same AWS account</p>
</td>
</tr>
</tbody>
</table>

##  **Outputs**

|Name|	Description|
|------|:------------|
|endpoint|	The connection endpoint of the RDS Cluster|
|rds_instances|	Details of the rds instances are created in the cluster|
|database_name|	The database name|


