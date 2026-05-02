REM "root-ca.bat"
REM Usage: creer la CA
REM Creer la cle privee de CA. A ne faire qu'une fois. Personnaliser la taille de cle (1024, 2048)
openssl genrsa -des3 -out ca.key -rand seed.rnd 2048
REM Autosignature de la cle. Personnaliser la duree du certificat de CA (3650, 7300), en jours.
echo "Autosignature de la cle de CA"
openssl req -new -x509 -SHA1 -days 7300 -config root-ca.cnf -key ca.key -out ca.crt