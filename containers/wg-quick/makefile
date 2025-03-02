.PHONY: wg-quick
wg-quick: Containerfile
	nerdctl build --platform=amd64,arm64 --output type=image,name=docker.io/clanktron/wg-quick:latest,push=true .
