#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#

#
# Copyright (c) 2014, Joyent, Inc.
#

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

