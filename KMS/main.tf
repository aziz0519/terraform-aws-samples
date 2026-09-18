# ---------------------------------------------------------
# KMS Key (Symmetric)
# ---------------------------------------------------------
resource "aws_kms_key" "xfusion_kms_key" {
  description              = "Symmetric KMS key for encryption/decryption"
  key_usage                = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  is_enabled               = true

  tags = {
    Name = "xfusion-kms-key"
  }
}

# ---------------------------------------------------------
# Encrypt SensitiveData.txt using local-exec
# ---------------------------------------------------------
resource "null_resource" "encrypt_file" {
  depends_on = [aws_kms_key.xfusion_kms_key]

  provisioner "local-exec" {
    command = <<EOT
aws kms encrypt \
  --key-id ${aws_kms_key.xfusion_kms_key.key_id} \
  --plaintext fileb:///home/bob/terraform/SensitiveData.txt \
  --output text \
  --query CiphertextBlob | base64 --decode > /home/bob/terraform/EncryptedData.bin
EOT
  }
}

# ---------------------------------------------------------
# Decrypt the encrypted file and verify match
# ---------------------------------------------------------
resource "null_resource" "decrypt_file" {
  depends_on = [null_resource.encrypt_file]

  provisioner "local-exec" {
    command = <<EOT
aws kms decrypt \
  --ciphertext-blob fileb:///home/bob/terraform/EncryptedData.bin \
  --output text \
  --query Plaintext | base64 --decode > /home/bob/terraform/DecryptedData.txt

diff /home/bob/terraform/SensitiveData.txt /home/bob/terraform/DecryptedData.txt
EOT
  }
}