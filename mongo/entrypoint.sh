#!/bin/bash

/usr/local/bin/mongod --replSet "$replSet" \
	--bind_ip "0.0.0.0" --port "$port" \
	--dbpath "/data/db/" \
	--auth --keyFile "/data/db/replset.key" \
	--networkMessageCompressors zstd \
	--setParameter "transactionLifetimeLimitSeconds=13" &

[ ! -f "/data/db/firstrun" ] && sleep 2 &&
	/usr/local/bin/mongo admin \
		--host localhost --port $port \
		--eval "$(envsubst </data/db/config.js)" &&
	touch "/data/db/firstrun"


pid="$!"
trap "kill $pid && exit 0" SIGQUIT SIGTERM
wait