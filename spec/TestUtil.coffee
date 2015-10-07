fs = require('fs-extra')
osenv = require('osenv')
path = require('path')

module.exports = TextUtil =
  noteFileExt: '.md'
  tempPath: osenv.tmpdir()
  demoPath: path.join(__dirname,'demoNote')
  testNotebookPath: null

  createNotebook: ->
    @testNotebookPath = path.join(@tempPath,'atom-note-test','test-note')
    fs.emptyDirSync(@testNotebookPath)
    return @testNotebookPath

  removeNotebook: ->
    fs.removeSync(@testNotebookPath)

  getNotebook: ->
    return @testNotebookPath if @testNotebookPath
    return @createNotebook()

  initNotebook: ->
    fs.copySync(@demoPath,@testNotebookPath)

  getNotebookJsonFilePath: ->
    return path.join(@testNotebookPath,'note.json')

  getJournalPath: (date=new Date())->
    path.join(@testNotebookPath,'Journal/'+date.getFullYear()+'/'+(date.getMonth()+1)+'/'+
      (if (''+date.getDate()).length==1 then '0'+date.getDate() else date.getDate())+@noteFileExt)
