sap.ui.define([
    "sap/m/MessageToast"
], function (MessageToast) {
    'use strict';

    return {
        change_status: function (oEvent) {
            debugger;
            MessageToast.show("Custom handler invoked.");
        }
    };
});
