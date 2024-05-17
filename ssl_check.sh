DOMAIN="example.com"
PORT="443"
LOG_FILE="ssl_check.log"

CERT_FILE="/etc/letsencrypt/live/$DOMAIN/fullchain.pem"

if [ -z "$CERT_FILE" ]; then
    echo "$(date): Certificate file for $DOMAIN not found."  \
    | tee -a $LOG_FILE
    exit 1
fi

EXPIRY_DATE=$(openssl x509 -in "$CERT_FILE" -noout -enddate 2>/dev/null \
| cut -d= -f2)
if [ -z "$EXPIRY_DATE" ]; then
    echo "$(date): Failed to retrieve the date for the SSL certificate of $DOMAIN." \
     | tee -a $LOG_FILE
    exit 1
fi


EXPIRY_DATE_SECONDS=$(date -d "$EXPIRY_DATE" +%s)
CURRENT_DATE_SECONDS=$(date +%s)
DAYS_UNTIL_EXPIRY=$(( ($EXPIRY_DATE_SECONDS - $CURRENT_DATE_SECONDS) / 86400 ))
echo "$(date): The SSL certificate for $DOMAIN will expire on \
$EXPIRY_DATE ($DAYS_UNTIL_EXPIRY days from now)." | tee -a $LOG_FILE
