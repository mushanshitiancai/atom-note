AtomNoteView = require './atom-note-view'
{CompositeDisposable} = require 'atom'
Editor = require './Edit'
Notebook = require "./module/notebook"
Util = require "./util/util"
NotebookCommand = require './commands/notebook-command'
NoteCommand = require './commands/NoteCommand'

TestView = require './views/test-view'
InputView = require './views/input-view'

module.exports = AtomNote =
  subscriptions: null


  activate: (state) ->
    console.log "atom-note activate"
    @subscriptions = new CompositeDisposable
    editor = new Editor

    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-note:create-notebook': => NotebookCommand.create_notebook()
    # @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-list-new-line': => editor.insertNewLine()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:test': => @test()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-image': (e)=> NoteCommand.insert_image(e)
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-note:open-today-journal': => NotebookCommand.open_today_journal()

    process.nextTick =>
      @parseNotebook()

  deactivate: ->
    console.log "atom-note deactivate"
    @subscriptions.dispose()

  serialize: ->

  parseNotebook: ->
    Notebook.getActiveNotebook()

  test: ->
    console.log("test")
    # view = new AtomNoteView
    # view.display()
    t = new TestView
    t.display()
