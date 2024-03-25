#!/bin/bash

read -p "Write username: " NAME
echo "What kind of user is?"
echo "1. Reader"
echo "2. Contributor"
echo "3. Owner"
read -p "Enter the corresponding number for the user type: " OPTION

case $OPTION in
    1) USER_TYPE="reader";;
    2) USER_TYPE="contributor";;
    3) USER_TYPE="owner";;
    *) echo "Invalid option"; exit 1;;
esac

SECRET=$(pwgen -1)

if [ "$USER_TYPE" = "owner" ]; then
    CERT_TYPE=template-client-owner
else
    CERT_TYPE=template-client
fi

TEMPLATE=$(sed -e "s/\$NAME/$NAME/g" -e "s/\$SECRET/$SECRET/g" -e "s/\$CERT_TYPE/$CERT_TYPE/g" -e "s/\$USER_TYPE/$USER_TYPE/g" <<EOF
/certificate remove $NAME
/certificate add copy-from=$CERT_TYPE name=$NAME common-name=$NAME@DOMAIN.com subject-alt-name=email:$NAME@DOMAIN.com
/certificate sign $NAME ca=ca
/certificate set trusted=yes $NAME
/certificate export-certificate $NAME type=pkcs12 export-passphrase=$SECRET
/ip ipsec identity set [find remote-id="user-fqdn:$NAME@DOMAIN.com"] mode-config="modeconfig-ikev2-$USER_TYPE" remote-certificate=$NAME
EOF
)

ssh user@192.168.1.1 "$TEMPLATE"

if [ ! -d "Certs" ]; then
    mkdir Certs
fi
sftp user@192.168.1.1:cert_export_ca.crt && mv cert_export_ca.crt Certs/
sftp user@192.168.1.1:cert_export_$NAME.p12 && mv cert_export_$NAME.p12 Certs/

echo "Done. The secret is \"$SECRET\" and the necessary files have been downloaded to the \"Certs\" folder."