NotebookUtil = require('../util/NotebookUtil')

module.exports = NotebookCommand =
  open_today_journal: ->
    NotebookUtil.openJournal(new Date())
