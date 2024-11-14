#!/bin/bash

# Set file names and validity period
CA_KEY="ca.key"
CA_CERT="ca.crt"
SERVER_KEY="transport.key"
SERVER_CSR="transport.csr"
SERVER_CERT="transport.crt"
DAYS=365

# Generate a CA private key
echo "Generating CA private key..."
openssl genpkey -algorithm RSA -out $CA_KEY
echo "CA private key saved as $CA_KEY"

# Generate a self-signed CA certificate
echo "Generating CA certificate..."
openssl req -x509 -new -key $CA_KEY -sha256 -days $DAYS -out $CA_CERT -subj "/C=US/ST=SomeState/L=SomeCity/O=ExampleOrg/OU=ExampleUnit/CN=example.com"
echo "CA certificate saved as $CA_CERT"

# Generate a private key for the server
echo "Generating server private key..."
openssl genpkey -algorithm RSA -out $SERVER_KEY
echo "Server private key saved as $SERVER_KEY"

# Generate a CSR for the server
echo "Generating server CSR..."
openssl req -new -key $SERVER_KEY -out $SERVER_CSR -subj "/C=US/ST=SomeState/L=SomeCity/O=ExampleOrg/OU=ExampleUnit/CN=example.com"
echo "Server CSR saved as $SERVER_CSR"

# Generate the server certificate signed by the CA
echo "Signing server certificate with CA..."
openssl x509 -req -in $SERVER_CSR -CA $CA_CERT -CAkey $CA_KEY -CAcreateserial -out $SERVER_CERT -days $DAYS -sha256
echo "Server certificate saved as $SERVER_CERT"

# Clean up CSR
rm $SERVER_CSR

echo "Certificate generation completed:"
echo "CA Certificate: $CA_CERT"
echo "CA Key: $CA_KEY"
echo "Server Certificate: $SERVER_CERT"
echo "Server Key: $SERVER_KEY"

