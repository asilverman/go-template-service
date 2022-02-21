SHELL := /bin/bash


export GOBIN=${PWD}/tools/bin
export PATH:=${GOBIN}:${PATH}
$(info [INFO]: $$GOBIN is set to ${GOBIN} )

toolsGo := tools/tools.go
toolsDir := tools/bin

toolPkgs := $(shell go list -f '{{join .Imports " "}}' ${toolsGo})
toolCmds := $(foreach tool,$(notdir ${toolPkgs}),${toolsDir}/${tool})
# The magic in the line below defines <toolname>Cmd variables (e.g. stringerCmd, mockgenCmd, etc.) to be used in other recipes in your Makefile.
$(foreach cmd,${toolCmds},$(eval $(notdir ${cmd})Cmd := ${cmd}))

go.mod: ${toolsGo}
	go mod tidy
	touch go.mod

${toolCmds}: go.mod
	go install ${toolPkgs}

tools: ${toolCmds}

.PHONY: tools


	

