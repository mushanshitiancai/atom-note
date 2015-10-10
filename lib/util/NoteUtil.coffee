fs   = require('fs-extra')
path = require('path')
Util = require('./Util')
moment = require('moment')
yaml = require('js-yaml')

module.exports = NoteUtil =

  initNote: (notePath,title,date=new Date())->
    return unless notePath
    try
      fs.statSync(notePath)
      # note is existed
    catch error
      headerStr = "---\n"+yaml.safeDump(@generateNoteHeader(date))+"---\n\n"
      headerStr += "# #{title}\n"
      fs.outputFileSync(notePath,headerStr)

  generateNoteHeader: (date=new Date())->
    return date:moment(date).format()
