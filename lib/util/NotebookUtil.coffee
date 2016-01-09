fs   = require('fs')
path = require('path')
Util = require('./Util')
NoteUtil = require('./NoteUtil')
momnet = require('moment')

module.exports = NotebookUtil =
  noteFileExt: '.md'

  createNotebook: () ->
    

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
    return if not journalPath = @getJournalPath(date)

    # try to init note
    NoteUtil.initNote(journalPath,momnet(date).format('YYYY年MM月DD日'))

    return atom.workspace.open(journalPath)
