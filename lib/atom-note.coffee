AtomNoteView = require './atom-note-view'
{CompositeDisposable} = require 'atom'
Editor = require './Edit'
Notebook = require "./module/Notebook"
Util = require "./util/Util"
NotebookCommand = require './commands/NotebookCommand'
NoteCommand = require './commands/NoteCommand'

TestView = require './views/test-view'
InputView = require './views/input-view'

global.notebook = new Notebook;

module.exports = AtomNote =
  subscriptions: null


  activate: (state) ->
    console.log "atom-note activate"
    @subscriptions = new CompositeDisposable
    editor = new Editor
    # @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-list-new-line': => editor.insertNewLine()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:test': => @test()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-image': (e)=> NoteCommand.insert_image(e)
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-note:open-today-journal': => NotebookCommand.open_today_journal()

    # workspaceElement = atom.views.getView(atom.workspace)
    # workspaceElement.addEventListener 'keydown',(e)=>
    #   if(e.metaKey && e.keyCode == 86)
    #     # alert('fuck');

    # dialog
    # process.nextTick ->
    # t = new TestView
    # t.display()
    # inputView = new InputView({
    #   onConfirm: (text)-> console.log text
    #   });
    # inputView.display('hehe')

    InputView.display('hehe',(text)-> console.log text);


  deactivate: ->
    console.log "atom-note deactivate"
    @subscriptions.dispose()

  serialize: ->


  test: ->
    console.log("test")
    # view = new AtomNoteView
    # view.display()
    t = new TestView
    t.display()
