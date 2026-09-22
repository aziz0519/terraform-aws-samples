# ---------------------------
# DynamoDB Table
# ---------------------------
resource "aws_dynamodb_table" "devops_tasks" {
  name         = var.KKE_TABLE_NAME
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "taskId"

  attribute {
    name = "taskId"
    type = "S"
  }
}

# ---------------------------
# Insert Task 1
# ---------------------------
resource "aws_dynamodb_table_item" "task1" {
  table_name = aws_dynamodb_table.devops_tasks.name
  hash_key   = aws_dynamodb_table.devops_tasks.hash_key

  item = <<ITEM
{
  "taskId":      {"S": "1"},
  "description": {"S": "Learn DynamoDB"},
  "status":      {"S": "completed"}
}
ITEM
}

# ---------------------------
# Insert Task 2
# ---------------------------
resource "aws_dynamodb_table_item" "task2" {
  table_name = aws_dynamodb_table.devops_tasks.name
  hash_key   = aws_dynamodb_table.devops_tasks.hash_key

  item = <<ITEM
{
  "taskId":      {"S": "2"},
  "description": {"S": "Build To-Do App"},
  "status":      {"S": "in-progress"}
}
ITEM
}