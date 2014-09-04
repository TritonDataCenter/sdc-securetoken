<!--
    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, You can obtain one at http://mozilla.org/MPL/2.0/.
-->

<!--
    Copyright (c) 2014, Joyent, Inc.
-->

# sdc-securetoken

This repository is part of the Joyent SmartDataCenter project (SDC).  For 
contribution guidelines, issues, and general documentation, visit the main
[SDC](http://github.com/joyent/sdc) project page.

## Overview

This repo provides a means of securely (encrypt-then-MAC) transferring data
between services in the public. Data is encoded into a token, which is provided
to a third-party client, and when the third-party provides that token again,
the data that was encoded inside can be extracted.

This is primarily useful for providing single-sign on, where a client gets a
token from a single authentication services, and can use that token with other
services to verify the client's identity.


# Example

Initialization:

    var SecureToken = require('sdc-securetoken');
    
    var exampleKey = {
        uuid: '8ea74e99-91d5-4207-9822-7096900b44c5',
        key: '499d7d5db79b25d9be22197d869b38bb8b2dbb5e86ba3565b4fbd542e1b1bd33',
        timestamp: '2014-03-25T10:47:19.342Z'
    };
    
    var tokenizer = new SecureToken(key, [key]);

A reminder that the key must remain secret.

Generate a token which can be returned to a client:

    var privateData = {
        foo: 'bar',
        baz: [1, 2, 3]
    };

    tokenizer.encrypt(privateData, function (err, securetoken) {
        // check err, then use securetoken as desired
    });

Verify and decode a token:

    var tokenFromClient = {
        keyid: '2022a43b-1699-46e9-9233-517a4dbeffd8',
        data: 'sC+TLQVLtY4ZOrZA05O6wknGgTketCllfb27/U91owcOK8c4BsbtYMiiE3XK+' +
              'zoM3sn8+v49rROdAGuhLpsiB9Se2Sb1srr6yRFhD8lD4bw8nmeafY5RmbPTH5' +
              'gsHBPax8khOiV81GFyRsuMPYDhPC8yXn5K149WtCe6/t+PUpCfVeMqp2QmVtA' +
              'VK34ieQlImLLdr0DFfRR+YMrveKql9Q==',
        version: '0.1.0',
        hash: '1f1a2RnG1luurUC+rkCXBccg3/gDTlf+Kdd364LwPEM='
    };

    tokenizer.decrypt(tokenFromClient, function (err, privateData) {
        // check err, then use privateData as desired
    });
