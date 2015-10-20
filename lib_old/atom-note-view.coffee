{$, View, TextEditorView} = require "atom-space-pen-views"

module.exports =
class AtomNoteView extends View
  @content: ->
    @div class: "atom-note atom-note-dialog",=>
      @label "Create a new Notebook", class: "icon"
      @div =>
        @label "notebook path:"
        @subview "notebookPath",new TextEditorView(mini:true)


  initialize: ->
    atom.commands.add @element,
      "core:confirm" : => @onConfirm()
      "core:cancel"  : => @detach()

  display: ->
    @panel ?= atom.workspace.addModalPanel(item:this,visible:false)
    @panel.show()
    @notebookPath.focus()

    @notebookPath.setText(atom.project.getPaths()[0])

  detach: ->
    if @panel.isVisible()
      @panel.hide()
    super

  onConfirm: ->
    if notebook.create(@notebookPath.getText())
      console.log 'create success'
      @detach()
