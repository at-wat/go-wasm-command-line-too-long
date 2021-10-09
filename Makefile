GO_VERSION = 1.17.2

.PHONY: run
run: go_js_wasm_exec wasm_exec.js
	GOOS=js GOARCH=wasm go build -o go-wasm-command-line-too-long .
	./go_js_wasm_exec ./go-wasm-command-line-too-long

.PHONY: clean
clean:
	@rm -f .go-version-* go_js_wasm_exec wasm_exec.js

.go-version-$(GO_VERSION):
	@rm -f .go-version-*
	@touch $@

go_js_wasm_exec: .go-version-$(GO_VERSION)
	@wget -q https://raw.githubusercontent.com/golang/go/go$(GO_VERSION)/misc/wasm/$@ -O $@
	@chmod +x $@

wasm_exec.js: .go-version-$(GO_VERSION)
	@wget -q https://raw.githubusercontent.com/golang/go/go$(GO_VERSION)/misc/wasm/$@ -O $@
