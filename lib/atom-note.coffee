AtomNoteView = require './atom-note-view'
{CompositeDisposable} = require 'atom'
Editor = require './Edit'
Notebook = require "./module/Notebook"

global.notebook = new Notebook;

module.exports = AtomNote =
  subscriptions: null


  activate: (state) ->
    @subscriptions = new CompositeDisposable
    editor = new Editor
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:insert-list-new-line': => editor.insertNewLine()
    @subscriptions.add atom.commands.add 'atom-text-editor', 'atom-note:test': => @test()


  deactivate: ->
    @subscriptions.dispose()

  serialize: ->

  test: ->
    view = new AtomNoteView
    view.display()
