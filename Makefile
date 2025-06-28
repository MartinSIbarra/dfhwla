.PHONY: \
	build-all \
	build-ngrok-nginx-proxy \
	build-wireguard-vpn-server \
	build-fake-prod-server \
	build-fake-uat-server \
	push-ngrok-nginx-proxy \
	push-wireguard-vpn-server \
	push-fake-prod-server \
	push-fake-uat-server
	
clean-images:
	docker rmi -f \
		ngrok-nginx-proxy:alpine \
		wireguard-vpn-server:alpine \
		fake-prod-server:alpine \
		fake-uat-server:alpine
	docker builder prune -f

build-all: \
	build-ngrok-nginx-proxy \
	build-wireguard-vpn-server \
	build-fake-prod-server \
	build-fake-uat-server

build-ngrok-nginx-proxy:
	./common/helpers/build.sh "ngrok-nginx-proxy" "alpine"

build-wireguard-vpn-server:
	./common/helpers/build.sh "wireguard-vpn-server" "alpine"

build-fake-prod-server:
	./common/helpers/build.sh "fake-prod-server" "alpine"

build-fake-uat-server:
	./common/helpers/build.sh "fake-uat-server" "alpine"

push-ngrok-nginx-proxy:
	./common/helpers/push.sh "ngrok-nginx-proxy" "alpine"

push-wireguard-vpn-server:
	./common/helpers/push.sh "wireguard-vpn-server" "alpine"

push-fake-prod-server:
	./common/helpers/push.sh "fake-prod-server" "alpine"

push-fake-uat-server:
	./common/helpers/push.sh "fake-uat-server" "alpine"
