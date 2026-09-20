resource "aws_kms_key" "devops_kms_key" {
  description              = "KMS key for encryption"
  deletion_window_in_days  = 10
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  key_usage                = "ENCRYPT_DECRYPT"

  tags = {
    Name = "devops-kms-key"
  }

}

resource "aws_kms_alias" "devops_alias" {
  name          = "alias/devops-kms-key"
  target_key_id = aws_kms_key.devops_kms_key.key_id
}

data "local_file" "sensitive_file" {
  filename = "/home/bob/terraform/SensitiveData.txt"
}

resource "aws_kms_ciphertext" "devops_encrypted" {
  key_id    = aws_kms_key.devops_kms_key.key_id
  plaintext = data.local_file.sensitive_file.content
}

resource "local_file" "devops_encrypted_file" {
  content  = aws_kms_ciphertext.devops_encrypted.ciphertext_blob
  filename = "/home/bob/terraform/EncryptedData.bin"
}

data "aws_kms_secrets" "devops_decrypted" {
  secret {
    name    = "decrypted"
    payload = aws_kms_ciphertext.devops_encrypted.ciphertext_blob

  }
}

resource "local_file" "devops_decrypted_file" {
  content  = data.aws_kms_secrets.devops_decrypted.plaintext["decrypted"]
  filename = "/home/bob/terraform/DecryptedData.txt"
}