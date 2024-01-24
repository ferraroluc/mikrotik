#!/bin/bash

read -p "Write username: " NAME

SECRET=$(pwgen -1)
YEAR=$(date +"%Y")

TEMPLATE=$(sed -e "s/\$NAME/$NAME/g" -e "s/\$YEAR/$YEAR/g" -e "s/\$SECRET/$SECRET/g" <<EOF
/certificate add copy-from=template-client name=$NAME-$YEAR common-name=$NAME@DOMAIN.com subject-alt-name=email:$NAME@DOMAIN.com
/certificate sign $NAME-$YEAR ca=ca
/certificate set trusted=yes $NAME-$YEAR
/certificate export-certificate $NAME-$YEAR type=pkcs12 export-passphrase=$SECRET

/ip ipsec identity add auth-method=digital-signature certificate=server generate-policy=port-strict match-by=certificate mode-config=modeconfig-ikev2 peer=peer-wan policy-template-group=group-ikev2 remote-certificate=$NAME remote-id=user-fqdn:$NAME@DOMAIN.com
EOF
)

ssh user@192.168.1.1 "$TEMPLATE"

if [ ! -d "Certs" ]; then
    mkdir Certs
fi
sftp user@192.168.1.1:cert_export_ca.crt && mv cert_export_ca.crt Certs/
sftp user@192.168.1.1:cert_export_$NAME-$YEAR.p12 && mv cert_export_$NAME-$YEAR.p12 Certs/

echo "Ready. Secret is \"$SECRET\" and the necessary files were downloaded to the \"Certs\" folder."
