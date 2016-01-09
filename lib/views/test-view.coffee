{SelectListView} = require 'atom-space-pen-views'

module.exports=
class MyView extends SelectListView
  initialize: ->
    super
    @addClass('overlay from-top')
    @setItems(['Hello', 'World'])
    @focusFilterEditor()
 
  viewForItem: (item) ->
    "<li>#{item}</li>"
 
  confirmed: (item) ->
    console.log("#{item} was selected")
    "<li>hehe</li>"
 
  cancelled: ->
    console.log("This view was cancelled")
 
  display: ->
    atom.workspace.addModalPanel(item:this,visiable:true)