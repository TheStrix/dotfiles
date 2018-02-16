#!/bin/bash

# Colors
lightcyan='\e[1;36m'
lightred='\e[1;31m'
nc='\e[0m'

# Install go
if [[ -z $(which go) ]]; then
	echo -e "${lightred}go/golang not found, attempting install...${nc}"
	if [[ ! -z $(which apt-get)  ]]; then
		echo "Install golang (https://golang.org/doc/install)"
		exit 1
	elif [[ ! -z $(which yaourt) ]]; then
		yaourt -S go --noconfirm
	elif [[ ! -z $(which pacman) ]]; then
		sudo pacman -S go --noconfirm
	else
		echo "cannot detect any known package manager"
		exit 1
	fi
fi

# Configure directories
if [[ ! -d $C_ANDROIDTOOLSDIR/go ]]; then
	mkdir $C_ANDROIDTOOLSDIR/go
	export GOPATH=${C_ANDROIDTOOLSDIR}/go
	export GOBIN=$GOPATH/bin
	export PATH=$GOBIN:$PATH
fi

# Download the Battery Historian code and its dependencies
echo -e "${lightcyan}Downloading Battery Historian code and its dependencies...${nc}"
go get -d -u github.com/google/battery-historian/...

# Compile Javascript files using the Closure compiler
cd $GOPATH/src/github.com/google/battery-historian
go run setup.go

# Run Historian
echo -e "${lightgreen}Running historian...${nc}"
echo -e "${lightgray}Visit http://localhost:9999${nc}"
go run cmd/battery-historian/battery-historian.go
