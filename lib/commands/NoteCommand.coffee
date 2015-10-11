NoteUtil = require('../util/NoteUtil')

module.exports = NoteCommand =
  insert_image: (e)->
    NoteUtil.insertImage(e)
