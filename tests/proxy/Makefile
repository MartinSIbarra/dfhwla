
run-proxy-server: \
	create-prod-net \
	uat_net \
	rm-proxy-server \
	do-proxy-server-run \
	connect-proxy-prod-net \
	connect-proxy-uat-net 

do-proxy-server-run: create-prod-net create-uat-net
	docker run -dit \
		--name tunnel-proxy \
		--hostname tunnel-proxy \
		-v ./params:/root/params \
		-v ./config:/root/config \
		-v ./logs:/root/logs \
		--network create-prod-net \
		-p 5000:5000 \
		proxy-server:alpine

rm-proxy-server: 
	docker rm -f tunnel-proxy 2>/dev/null || true

run-fake-prod-server: create-prod-net rm-fake-prod-server
	docker run -dit \
		--name prod-server \
		--hostname prod-server \
		--network create-prod-net \
		-p 3000:3000 \
		fake-prod-server:alpine

rm-fake-prod-server:
	docker rm -f prod-server 2>/dev/null || true

run-fake-uat-server: create-uat-net rm-fake-uat-server
	docker run -dit \
		--name uat-server \
		--hostname uat-server \
		--network create-uat-net \
		-p 3001:3000 \
		fake-uat-server:alpine

rm-fake-uat-server:
	docker rm -f uat-server 2>/dev/null || true

proxy-run-bash:
	docker exec -it tunnel-proxy bash

connect-proxy-prod-net:
	docker network connect create-prod-net tunnel-proxy 2>/dev/null || true

connect-proxy-uat-net:
	docker network connect create-uat-net tunnel-proxy 2>/dev/null || true

create-prod-net:
	docker network create create-prod-net 2>/dev/null || true

create-uat-net:
	docker network create create-uat-net 2>/dev/null || true


