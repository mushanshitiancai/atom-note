var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var view = require('./view');
var $ = view.$;
var sp = require("atom-space-pen-views");
var InputView = (function (_super) {
    __extends(InputView, _super);
    function InputView() {
        _super.apply(this, arguments);
    }
    InputView.content = function () {
        var _this = this;
        return this.div({ class: 'fuck' }, function () {
            _this.div({ class: 'block' }, function () {
                _this.span({ class: 'heheheeh' }, 'hello');
            });
            _this.subview('fuck', new sp.TextEditorView({ mini: true }));
        });
    };
    InputView.prototype.test = function () {
    };
    return InputView;
})(view.View);
module.exports = InputView;
