var fs = require('fs-extra');
var Logger = require('./Logger');
var yaml = require('js-yaml');
var moment = require('moment');
var NoteUtil;
(function (NoteUtil) {
    function initNote(notePath, title, date) {
        if (date === void 0) { date = new Date(); }
        if (!notePath)
            return;
        try {
            var stats = fs.statSync(notePath);
            if (stats.size == 0) {
                _initNote(notePath, title, date);
            }
            else {
                Logger.d('note existed and no empty:' + notePath);
            }
        }
        catch (e) {
            _initNote(notePath, title, date);
        }
    }
    NoteUtil.initNote = initNote;
    function _initNote(notePath, title, date) {
        if (date === void 0) { date = new Date(); }
        var headerStr = "---\n" + yaml.safeDump(generateNoteHeader(date)) + "---\n\n";
        headerStr += "# " + title + "\n";
        fs.outputFileSync(notePath, headerStr);
    }
    function generateNoteHeader(date) {
        if (date === void 0) { date = new Date(); }
        return {
            date: moment(date).format()
        };
    }
})(NoteUtil || (NoteUtil = {}));
module.exports = NoteUtil;
