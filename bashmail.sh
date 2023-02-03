#!/bin/bash

# Instructions: 

if [ "$1" = "--help" ]; then
    echo -e "To generate the app password, follow the steps below:
    1. Access https://myaccount.google.com/u/2/apppasswords
    2. Select the \"Others\" and write \"bashmail\" to the name app 
    3. Copy and save the generated app password \n"
    exit
fi

echo -e "\nWelcome to the BashMail"
echo -e "Type mailsender --help to view the instructions \n"

read -p "Enter your email: " SENDER_MAIL
read -p "Enter the recipient's mail: " RECIPIENT_MAIL
read -p "Insert the generated Google App Password: " GOOGLE_APP_PASSWORD
read -p "Insert the subject of the mail: " MAIL_SUBJECT

echo "Enter the body of mail (PRESS CTRL + D TO SAVE):"
cat > tempfile.txt
body=$(cat tempfile.txt)

# The CURL command is used to fetch the Google SMTP Server.

curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
--mail-from $SENDER_MAIL \
--mail-rcpt $RECIPIENT_MAIL \
--user $SENDER_MAIL:$GOOGLE_APP_PASSWORD \
-T <(echo -e "From: ${SENDER_MAIL}
To: ${RECIPIENT_MAIL}
Subject: ${MAIL_SUBJECT}
${body}")&

rm ./tempfile.txt

echo -e ""