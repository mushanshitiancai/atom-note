var _ = require('lodash');
var fs = require('fs');
var Util;
(function (Util) {
    Util.FILENAME_REGEX = /\w+[-|\w]*/;
    Util.IMG_PREFIX_REGEX = /img\:\w+[-|\w]*/;
    var Project;
    (function (Project) {
        function getProjectPaths() {
            return atom.project.getPaths();
        }
        Project.getProjectPaths = getProjectPaths;
        function getActiveProjectPaths() {
            var paths = atom.project.getPaths();
            var realPaths = _.map(paths, Path.getRealPath);
            var activityTextEditor = atom.workspace.getActiveTextEditor();
            if (activityTextEditor) {
                var activityFilePath = Path.getRealPath(activityTextEditor.getPath());
            }
            else {
                return [];
            }
            var result = [];
            for (var _i = 0; _i < paths.length; _i++) {
                var path = paths[_i];
                if (path.startsWith(activityFilePath)) {
                    result.push(path);
                }
            }
            return result;
        }
        Project.getActiveProjectPaths = getActiveProjectPaths;
        function editFile(path) {
            atom.workspace.open(path, {});
        }
        Project.editFile = editFile;
    })(Project = Util.Project || (Util.Project = {}));
    var Path;
    (function (Path) {
        function getRealPath(path) {
            try {
                fs.statSync(path);
                return fs.realpathSync(path);
            }
            catch (e) {
                return path;
            }
        }
        Path.getRealPath = getRealPath;
    })(Path = Util.Path || (Util.Path = {}));
})(Util || (Util = {}));
module.exports = Util;
