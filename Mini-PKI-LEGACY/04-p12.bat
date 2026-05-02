REM "p12.bat"
REM Usage: rassemble les elements du certificat utilisateur et les met au format PKCS#12
REM Remplacer Username et CA NAME par les noms que vous avez entres lors de la creation des certificats user et CA
REM Laisser les guillemets autour des noms
openssl pkcs12 -export -in user.crt -inkey user.key -certfile ca.crt -name "Username" -caname "CA NAME" -out user.p12
echo " "
echo "Votre certificat utilisateur a ete cree au format PCKS#12"
echo "Vous pouvez l'importer dans votre navigateur"
echo " "