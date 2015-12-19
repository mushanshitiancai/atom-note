var InputView = require('./views/InputView');
function activate(state) {
    atom.commands.add('atom-text-editor', 'atom-note:test', function (event) {
        var view = new InputView({});
        atom.workspace.addModalPanel({ item: view, visible: true });
    });
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
function serialize() {
}
exports.serialize = serialize;
