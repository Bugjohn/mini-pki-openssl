REM "user-cert.bat"
REM Usage: creer le formulaire de demande de certificat utilisateur.
REM Creation de la cle. A faire pour chaque certificat. Personnaliser la taille de cle (1024, 2048).
openssl genrsa -out user.key -rand seed.rnd 2048
REM Remplir les donnes du certificat, nom d'utilisateur et adresse e-mail
echo "Remplir les donnees du certificat"
openssl req -new -config user-cert.cnf -key user.key -out user.csr
echo " "
echo "Vous pouvez maintenant lancer ca-sign.bat pour faire signer votre certificat"
echo " "