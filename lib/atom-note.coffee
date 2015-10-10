AtomNoteView = require './atom-note-view'
{CompositeDisposable} = require 'atom'
Editor = require './Edit'
Notebook = require "./module/Notebook"
Util = require "./util/Util"
NotebookCommand = require './commands/NotebookCommand'

global.notebook = new Notebook;

module.exports = AtomNote =
  subscriptions: null


  activate: (state) ->
    @subscriptions = new CompositeDisposable
    editor = new Editor
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-list-new-line': => editor.insertNewLine()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:test': => @test()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-image': => @insertImage()
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-note:open-today-journal': => NotebookCommand.open_today_journal()

    # workspaceElement = atom.views.getView(atom.workspace)
    # workspaceElement.addEventListener 'keydown',(e)=>
    #   if(e.metaKey && e.keyCode == 86)
    #     # alert('fuck');

  deactivate: ->
    console.log "atom-note deactivate"
    @subscriptions.dispose()

  serialize: ->

  insertImage: ->
    if not imgName = Util.getSelectedText()
      alert 'please select some text as the image name!'
      return

    clipboard = require('clipboard')
    img = clipboard.readImage();
    if not img
      return

    editor = atom.workspace.getActiveTextEditor()
    filePath = editor.getPath()

    path = require('path')
    fs   = require('fs')
    folderName = path.basename(filePath,'.md')
    folderPath = path.resolve(path.dirname(filePath),folderName)
    try
      folderStats = fs.statSync(folderPath)
    catch error
      fs.mkdirSync(folderPath)
      try
        folderStats = fs.statSync(folderPath)
      catch error
        alert('create folder fail!')

    if folderStats and folderStats.isDirectory()
      imgPath = path.resolve(folderPath,imgName+'.png')
      relativeImgPath = path.join(folderName,imgName+'.png')
      fs.writeFileSync(imgPath,img.toPng())
      Util.insertText("!["+imgName+"]("+relativeImgPath+")")





  test: ->
    # view = new AtomNoteView
    # view.display()
    Util.test()
