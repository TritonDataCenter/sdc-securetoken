JSL = deps/javascriptlint/build/install/jsl
JSS = deps/jsstyle/jsstyle

.PHONY: prepush check test

prepush: check test

check: $(JSL)
	$(JSL) --conf=tools/jsl.node.conf lib/*.js test/*.js
	$(JSS) -f tools/jsstyle.conf lib/*.js test/*.js

test:
	node test/securetoken.test.js

$(JSL):
	make -C deps/javascriptlint install

