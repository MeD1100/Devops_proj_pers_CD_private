#Resource to create s3 bucket

# resource "aws_s3_bucket" "demo-bucket"{
#   bucket = "s3backendtfstate-unique12"

#   tags = {
#     Name = "S3Bucket"
#   }
# }

# #Allow server-side encryption of state files for security.

# resource "aws_s3_bucket_server_side_encryption_configuration" "s3-bucket-backend-tf"{
#   bucket = "s3backendtfstate-unique12" #Needs to be unique
 
#     rule{
#       apply_server_side_encryption_by_default {
#         sse_algorithm = "AES256"
#       }
#     }
# }

# #Allow versioning

# resource "aws_s3_bucket_versioning" "versioning_s3" {
#   bucket = aws_s3_bucket_server_side_encryption_configuration.s3-bucket-backend-tf.bucket
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

#DynamoDB Enable state locks to prevent altering of AWS ressources linked to this state file in a case of use from multiple accounts.

resource "aws_dynamodb_table" "statelock" {
  name = "state-prod.lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
