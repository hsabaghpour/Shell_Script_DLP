#!/bin/bash

DIR="/sensitive_data"
ENCRYPT_DIR="/encrypted_data"
KEY="encryption_key.pem"

mkdir -p $ENCRYPT_DIR

for file in $DIR/*; do
  openssl enc -aes-256-cbc -salt -in "$file" -out "$ENCRYPT_DIR/$(basename "$file").enc" -pass file:$KEY
  echo "$(date): Encrypted file '$file' to '$ENCRYPT_DIR/$(basename "$file").enc'" >> /var/log/encryption.log
done

: << 'COMMENT'
Explanation:

openssl enc: Encrypts files using AES-256 encryption.
Purpose: Secures sensitive files before they are transferred or stored, reducing the risk of data leaks.
