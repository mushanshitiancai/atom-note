var fs = require('fs');
var path = require('path');
var Util = require('./Util');
var NotebookUtil;
(function (NotebookUtil) {
    var metaFile = 'note.json';
    function isLegalNotebook(projectPath) {
        try {
            fs.statSync(path.join(projectPath, metaFile));
            return true;
        }
        catch (e) {
            return false;
        }
    }
    function getActiveNotebook() {
        var paths = Util.Project.getActiveProjectPaths();
        for (var _i = 0; _i < paths.length; _i++) {
            var path_1 = paths[_i];
            if (isLegalNotebook(path_1)) {
                return path_1;
            }
        }
    }
    NotebookUtil.getActiveNotebook = getActiveNotebook;
})(NotebookUtil || (NotebookUtil = {}));
module.exports = NotebookUtil;
