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

echo "Ready. Secret is $SECRET"
