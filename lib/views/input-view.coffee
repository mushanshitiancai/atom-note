{$,View,TextEditorView} = require "atom-space-pen-views"

module.exports = 
class InputView extends View
  @content: ->
    @div class:'input-vew', =>
      @label outlet:'title','Please input:'
      @subview 'textEditor', new TextEditorView(mini: true)

  constructor: (@params={})->
    super

  initialize: ->
    atom.commands.add @element,
      "core:confirm": => @onConfirm()
      "core:cancel":  => @detach()

  onConfirm: ->
    @params?.onConfirm(@textEditor.getText())
    @detach()

  display: (title, placeholder, onConfirm)->
    @params.onConfirm = onConfirm
    @title.text(title)
    @textEditor.setText(placeholder)

    @panel ?= atom.workspace.addModalPanel(item: this, visible: false)
    @previousFocusElement = $(document.activeElement)
    @panel.show()
    @textEditor.focus()

  detach: ->
    return unless @panel.isVisible()
    @panel.hide()
    @previousFocusElement?.focus()
    #super