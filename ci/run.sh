#!/bin/bash

echo This is a ping message. > body.txt

for i in $(seq 0 2); do
	sender_varname=SENDER$i
	sender=${!sender_varname}
	receiver_varname=RECEIVER$i
	receiver=${!receiver_varname}
	smtp_varname=SMTP$i
	smtp=${!smtp_varname}
	password_varname=PASSWORD$i
	password=${!password_varname}

	sendEmail \
		-f $sender \
		-u "Scheduled Task" \
		-t $receiver \
		-s $smtp \
		-o tls=yes \
		-xu $sender \
		-xp $password \
		-o message-file="body.txt" \
		> /dev/null \
		2>&1
done

rm body.txt
