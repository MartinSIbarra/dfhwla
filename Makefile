.PHONY: \
	build-all \
	build-tunnel-server \
	build-vpn-server \
	build-proxy-server \
	build-ddns-updater \
	build-fake-prod-server \
	build-fake-uat-server \
	rm-tunnel-server \
	rm-vpn-server \
	rm-proxy-server \
	rm-ddns-updater \
	rm-fake-prod-server \
	rm-fake-uat-server \
	push-tunnel-server \
	push-vpn-server \
	push-proxy-server \
	push-ddns-updater \
	push-fake-prod-server \
	push-fake-uat-server 

clean-images:
	docker rmi -f \
		tunnel-server:alpine \
		vpn-server:alpine \
		proxy-server:alpine \
		ddns-updater:alpine \
		fake-prod-server:alpine \
		fake-uat-server:alpine \
	docker builder prune -f

build-all: \
	build-tunnel-server \
	build-vpn-server \
	build-proxy-server \
	build-ddns-updater \
	build-fake-prod-server \
	build-fake-uat-server

build-tunnel-server: rm-tunnel-server
	./common/helpers/build.sh "tunnel-server" "alpine"

push-tunnel-server:
	./common/helpers/push.sh "tunnel-server" "alpine"

rm-tunnel-server:
	docker rm -f tunnel-server 2>/dev/null || true

build-vpn-server: rm-vpn-server
	./common/helpers/build.sh "vpn-server" "alpine"

push-vpn-server:
	./common/helpers/push.sh "vpn-server" "alpine"

rm-vpn-server:
	docker rm -f vpn-server 2>/dev/null || true

build-proxy-server: rm-proxy-server
	./common/helpers/build.sh "proxy-server" "alpine"

push-proxy-server:
	./common/helpers/push.sh "proxy-server" "alpine"

rm-proxy-server:
	docker rm -f proxy-server 2>/dev/null || true

build-ddns-updater: rm-ddns-updater
	./common/helpers/build.sh "ddns-updater" "alpine"

push-ddns-updater:
	./common/helpers/push.sh "ddns-updater" "alpine"

rm-ddns-updater:
	docker rm -f ddns-updater 2>/dev/null || true

build-fake-prod-server: rm-fake-prod-server
	./common/helpers/build.sh "fake-prod-server" "alpine"

rm-fake-prod-server:
	docker rm -f fake-prod-server 2>/dev/null || true

push-fake-prod-server:
	./common/helpers/push.sh "fake-prod-server" "alpine"

build-fake-uat-server: rm-fake-uat-server
	./common/helpers/build.sh "fake-uat-server" "alpine"

rm-fake-uat-server:
	docker rm -f fake-uat-server 2>/dev/null || true

push-fake-uat-server:
	./common/helpers/push.sh "fake-uat-server" "alpine"
