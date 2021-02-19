
## How To run
1st run initiate_pre script to create terraform provisioning state storage and lock using s3 and dynamo db. It has to be defined before creation of resources

### Step 1
> **Command**.
> The bucket and dynamo db for the provision have the same 
>> ./scripts/initiate_pre.sh ${Resource_name} ${AWS_REGION} ${AWS_PROFILE}

### Step 2
> **Command**.
> Initiate state storage, locks, terraform, plugins
> Commands are ran within the environment folder
>> terraform init

### Step 3
> **Command**.
> run terraform plan to a rev{int} file
> Commands are ran within the environment folder
>> terraform plan -out rev{int}

### Step 3
> **Command**.
> run terraform apply to a rev{int} file or direct
> Commands are ran within the environment folder
>> terraform apply rev{int}.json
>> terraform apply {stage-src}