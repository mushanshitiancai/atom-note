AtomNoteView = require './atom-note-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomNote =
  atomNoteView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomNoteView = new AtomNoteView(state.atomNoteViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomNoteView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-note:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomNoteView.destroy()

  serialize: ->
    atomNoteViewState: @atomNoteView.serialize()

  toggle: ->
    console.log 'AtomNote was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
