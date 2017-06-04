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

	mailx -S smtp-auth=login \
		-S smtp=smtps://$smtp \
		-S smtp-auth-user=$sender \
		-S smtp-auth-password=$password \
		-r $sender \
		-s "Scheduled Task" \
		$receiver \
		< body.txt \
		> /dev/null \
		2>&1
done

rm body.txt
