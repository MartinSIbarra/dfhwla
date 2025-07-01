run-tunnel-server: \
	create-proxy-net \
	rm-tunnel-server \
	do-tunnel-server-run \
	run-proxy-server 

run-proxy-server: \
	create-proxy-net \
	rm-proxy-server \
	do-proxy-server-run \
	rm-fake-prod-server \
	run-fake-prod-server \
	rm-fake-uat-server \
	run-fake-uat-server \
	connect-proxy-prod-net \
	connect-proxy-uat-net 

do-tunnel-server-run: create-proxy-net
	docker run -dit \
		--name tunnel-server \
		--hostname tunnel-server \
		-v ./params:/root/params \
		-v ./logs:/root/logs \
		--network proxy-net \
		tunnel-server:alpine

rm-tunnel-server: 
	docker rm -f tunnel-server 2>/dev/null || true

do-proxy-server-run: create-proxy-net create-prod-net create-uat-net
	docker run -dit \
		--name proxy-server \
		--hostname proxy-server \
		-v ./params:/root/params \
		-v ./config:/root/config \
		-v ./logs:/root/logs \
		--network proxy-net \
		proxy-server:alpine

rm-proxy-server: 
	docker rm -f proxy-server 2>/dev/null || true

run-fake-prod-server: create-prod-net rm-fake-prod-server
	docker run -dit \
		--name prod-server \
		--hostname prod-server \
		--network prod-net \
		fake-prod-server:alpine

rm-fake-prod-server:
	docker rm -f prod-server 2>/dev/null || true

run-fake-uat-server: create-uat-net rm-fake-uat-server
	docker run -dit \
		--name uat-server \
		--hostname uat-server \
		--network uat-net \
		fake-uat-server:alpine

rm-fake-uat-server:
	docker rm -f uat-server 2>/dev/null || true

proxy-run-bash:
	docker exec -it proxy-server bash

connect-proxy-prod-net:
	docker network connect prod-net proxy-server 2>/dev/null || true

connect-proxy-uat-net:
	docker network connect uat-net proxy-server 2>/dev/null || true

create-proxy-net:
	docker network create proxy-net 2>/dev/null || true

create-prod-net:
	docker network create prod-net 2>/dev/null || true

create-uat-net:
	docker network create uat-net 2>/dev/null || true

set-tree-folders:
	[ -e params ] || ln -s ../../z.params params
