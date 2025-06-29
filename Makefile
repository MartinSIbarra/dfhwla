.PHONY: \
	build-all \
	build-tunnel-server \
	build-vpn-server \
	build-proxy-server \
	build-ddns-updater \
	push-tunnel-server \
	push-vpn-server \
	push-proxy-server \
	push-ddns-updater
	
clean-images:
	docker rmi -f \
		tunnel-server:alpine \
		vpn-server:alpine \
		proxy-server:alpine \
		ddns-updater:alpine \
	docker builder prune -f

build-all: \
	build-tunnel-server \
	build-vpn-server \
	build-proxy-server \
	build-ddns-updater

build-tunnel-server:
	./common/helpers/build.sh "tunnel-server" "alpine"

push-tunnel-server:
	./common/helpers/push.sh "tunnel-server" "alpine"

build-vpn-server:
	./common/helpers/build.sh "vpn-server" "alpine"

push-vpn-server:
	./common/helpers/push.sh "vpn-server" "alpine"

build-proxy-server:
	./common/helpers/build.sh "proxy-server" "alpine"

push-proxy-server:
	./common/helpers/push.sh "proxy-server" "alpine"

build-ddns-updater:
	./common/helpers/build.sh "ddns-updater" "alpine"

push-ddns-updater:
	./common/helpers/push.sh "ddns-updater" "alpine"

# Older versions of the Makefile
build-ngrok-nginx-proxy:
	./common/helpers/build.sh "ngrok-nginx-proxy" "alpine"

build-wireguard-vpn-server:
	./common/helpers/build.sh "wireguard-vpn-server" "alpine"

build-fake-prod-server:
	./common/helpers/build.sh "fake-prod-server" "alpine"

build-fake-uat-server:
	./common/helpers/build.sh "fake-uat-server" "alpine"bu

push-ngrok-nginx-proxy:
	./common/helpers/push.sh "ngrok-nginx-proxy" "alpine"

push-wireguard-vpn-server:
	./common/helpers/push.sh "wireguard-vpn-server" "alpine"

push-fake-prod-server:
	./common/helpers/push.sh "fake-prod-server" "alpine"

push-fake-uat-server:
	./common/helpers/push.sh "fake-uat-server" "alpine"
