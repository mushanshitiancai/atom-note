NotebookUtil = require('../util/notebook-util')
DialogUtil   = require('../util/dialog-util')
Util         = require('../util/util')
Notebook     = require('../module/notebook')

module.exports = NotebookCommand =
  create_notebook: ()->
    defaultPath = Util.getActiveProjectPath() or Util.getProjectPaths()[0] or ""
    DialogUtil.showCreateNotebookDialog 'Enter path to create notebook:', defaultPath, (path)->
      Notebook.createNotebook(path)

  open_today_journal: ->
    NotebookUtil.openJournal(new Date())
