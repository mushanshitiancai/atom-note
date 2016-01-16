InputView = require "../views/input-view"

module.exports = DialogUtil =
  inputView: null

  showCreateNotebookDialog: (title, placeholder, onConfirm)->
    @inputView ?= new InputView()
    @inputView.display(title, placeholder, onConfirm)
