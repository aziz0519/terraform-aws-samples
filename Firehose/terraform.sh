!#/bin/bash

terraform init

terraform fmt

terraform validate

terraform plan

terraform apply -auto-approve

aws firehose put-record \
  --delivery-stream-name xfusion-firehose-stream \
  --record '{"Data":"dGVzdC1kYXRhLXJlY29yZA=="}'

# List delivered files
aws s3 ls s3://xfusion-stream-bucket-15589/ --recursive

# Check that records end with newline
aws s3 cp s3://xfusion-stream-bucket-15589/<path-to-file> - | cat -A | head