# nombre d'instances
AWS_INSTANCE_NUMBER=2

docker container run -it --rm \
  --env-file .env \
  -v $PWD/terraform:$PWD \
  -w $PWD \
  -e TF_VAR_aws_instance_number=$AWS_INSTANCE_NUMBER \
  hashicorp/terraform init

docker container run -it --rm \
  --env-file .env \
  -v $PWD/terraform:$PWD \
  -w $PWD \
  -e TF_VAR_aws_instance_number=$AWS_INSTANCE_NUMBER \
  hashicorp/terraform plan

docker container run -it --rm \
  --env-file .env \
  -v $PWD/terraform:$PWD \
  -w $PWD \
  -e TF_VAR_aws_instance_number=$AWS_INSTANCE_NUMBER \
  hashicorp/terraform apply \
  -auto-approve \
  > tmp/info


# Extraction dns et ip
app_server_public_dns=($(grep -A $AWS_INSTANCE_NUMBER "app_server_public_dns =" tmp/info | tail -n $AWS_INSTANCE_NUMBER | awk -F '"' '{print $2}'))
app_server_public_ip=($(grep -A $AWS_INSTANCE_NUMBER "app_server_public_ip =" tmp/info | tail -n $AWS_INSTANCE_NUMBER | awk -F '"' '{print $2}'))