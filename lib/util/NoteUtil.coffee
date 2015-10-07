fs   = require('fs-extra')
path = require('path')
Util = require('./Util')
momnet = require('moment')

module.exports = NoteUtil =

  initNote: (notePath)->
    try
      fs.stat(notePath)
    catch error
      fs.outputFileSync(notePath,)

  generateNoteHeader: (date=new Date())->
    return date:moment(date).format()
