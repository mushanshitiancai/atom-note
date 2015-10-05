
module.exports = Util =
  getSelectedText: ->
    return atom.workspace.getActiveTextEditor().getSelectedText()
