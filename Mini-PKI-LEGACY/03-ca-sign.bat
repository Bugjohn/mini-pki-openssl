REM "ca-sign.bat"
REM Usage: signer un certificat d'utilisateur avec la cle de CA
REM Utiliser le mot de passe entre lors de la creation de CA
echo "signature par la CA: user.csr -> user.crt:"
openssl ca -config ca-sign.cnf -out user.crt -batch -infiles user.csr
echo "verification par la CA user.crt <-> CA cert"
openssl verify -CAfile ca.crt user.crt