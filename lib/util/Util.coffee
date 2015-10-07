_ = require('lodash')
fs = require('fs')

module.exports = Util =
  getProjectPaths: ->
    return atom.project.getPaths()

  # get the active project path according to active text editor.
  # if there isn't a active text editor, return first project path
  # if there isn't a project open in atom, return undefined
  # attention! getActiveTextEditor()?.getPath() return the real path, so be careful
  getActiveProjectPath: ->
    paths = atom.project.getPaths()
    realPaths = _.map(paths,@realPath)
    activeFilePath = atom.workspace.getActiveTextEditor()?.getPath()
    return paths[0] if not activeFilePath
    realActiveFilePath = @realPath(activeFilePath)

    legalPathIndex = (i for v,i in realPaths when realActiveFilePath.startsWith(v))
    legalPaths = (paths[i] for v,i in legalPathIndex)
    return undefined if legalPaths.length == 0
    return legalPaths[0] if legalPaths.length == 1
    return legalPaths

  getActiveTextEditorPath: ->
    return atom.workspace.getActiveTextEditor()?.getPath()

  insertText: (text)->
    return atom.workspace.getActiveTextEditor()?.insertText(text)

  getSelectedText: ->
    return atom.workspace.getActiveTextEditor()?.getSelectedText()

  realPath: (path)->
    try
      fs.statSync(path)
      return fs.realpathSync(path)
    catch error
      return path
