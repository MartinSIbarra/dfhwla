
run-proxy: \
	prod_net \
	uat_net \
	do-proxy-run \
	proxy-connect-prod-net \
	proxy-connect-uat-net 

do-proxy-run: prod_net uat_net
	docker rm -f tunnel-proxy 2>/dev/null || true
	docker run -dit \
		--name tunnel-proxy \
		--hostname tunnel-proxy \
		-v ./params:/root/params \
		-v ./config:/root/config \
		-v ./logs:/root/logs \
		--network prod_net \
		-p 5000:5000 \
		ngrok-nginx-proxy:alpine

run-fake-prod-server: prod_net
	docker rm -f prod-server 2>/dev/null || true
	docker run -dit \
		--name prod-server \
		--hostname prod-server \
		--network prod_net \
		-p 3000:3000 \
		fake-prod-server:alpine

run-fake-uat-server: uat_net
	docker rm -f uat-server 2>/dev/null || true
	docker run -dit \
		--name uat-server \
		--hostname uat-server \
		--network uat_net \
		-p 3001:3000 \
		fake-uat-server:alpine

proxy-run-bash:
	docker exec -it tunnel-proxy bash

proxy-connect-prod-net:
	docker network connect prod_net tunnel-proxy 2>/dev/null || true

proxy-connect-uat-net:
	docker network connect uat_net tunnel-proxy 2>/dev/null || true


prod_net:
	docker network create prod_net 2>/dev/null || true

uat_net:
	docker network create uat_net 2>/dev/null || true


