var Logger;
(function (Logger) {
    var isDebug = true;
    var perfix = 'atom-note: ';
    function debug(any) {
        if (isDebug)
            console.log(perfix + any);
    }
    Logger.debug = debug;
    Logger.d = debug;
})(Logger || (Logger = {}));
module.exports = Logger;
