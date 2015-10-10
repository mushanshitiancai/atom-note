fs   = require('fs')
path = require('path')
Util = require('../util/Util')
NoteUtil = require('../util/NoteUtil')
NotebookUtil = require('../util/NotebookUtil')

module.exports = NotebookCommand =
  open_today_journal: ->
    NotebookUtil.openJournal(new Date())
