CFLAGS=-g
export CFLAGS

ifeq '$(findstring ;,$(PATH))' ';'
    detected_OS := Windows
else
    detected_OS := $(shell uname 2>/dev/null || echo Unknown)
    detected_OS := $(patsubst CYGWIN%,Cygwin,$(detected_OS))
    detected_OS := $(patsubst MSYS%,MSYS,$(detected_OS))
    detected_OS := $(patsubst MINGW%,MSYS,$(detected_OS))
endif

ifeq ($(detected_OS),Windows)
  $(eval gradle:=gradlew)
else
  $(eval gradle:=./gradlew)
endif

null :=
space := ${null} ${null}
${space} := ${space}# ${ } is a space. Neat huh?

.PHONY: help feature ip simulator open-sim output

help:
	@echo ''
	@awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Utility
feature: ## Create feature folder
	@read -p 'Enter feature name: ' name; \
	echo \\nCreating feature $$name; \
	mkdir -p lib/features/$$name/{data/{datasources,models,repositories},domain/{entities,usecases,repositories},presentation/{bloc,widgets,pages}}; \
	echo Feature $$name created

ip: ## get current ip address
	@ifconfig | grep "inet " | grep -Fv 127.0.0.1

simulator: ## List of ios simulator
	@xcrun simctl list | grep -E "Booted|Shutdown"

output: ## open build output folder
	@open build/app/outputs/

open-sim: simulator ## open simulator
	@read -p 'Enter udid: ' uid;\
	open -a Simulator; \
	xcrun simctl boot $$uid

##@ Build
apk: ## Create apk file
	@flutter build apk
