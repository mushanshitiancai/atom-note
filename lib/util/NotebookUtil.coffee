fs   = require('fs')
path = require('path')
Util = require('./Util')
momnet = require('moment')

module.exports = NotebookUtil =
  noteFileExt: '.md'

  isLegalNotebook: (projectPath)->
    if projectPath
      try
        fs.statSync(path.join(projectPath,'note.json'))
        return projectPath
      catch error
        return false
    else
      return @getActiveNotebookPath()

  # return notebook path
  # return false: if there isn't a legal atom-note project
  getActiveNotebookPath: ->
    projectPath = Util.getActiveProjectPath()
    if typeof projectPath is "string"
      return @isLegalNotebook(projectPath)
    else if typeof projectPath is "object"
      for p in projectPath
        if ret = @isLegalNotebook(p)
          return ret

  getJournalPath: (date=new Date())->
    return undefined if not notebookPath = @isLegalNotebook()
    return path.join(notebookPath,'Journal/'+momnet(date).format('YYYY/MM/DD')+@noteFileExt)

  openJournal: (date=new Date())->
    return atom.workspace.open(journalPath) if journalPath = @getJournalPath()
