_ = require('lodash')
fs = require('fs')

module.exports = ProjectUtil = 

  # get the active project path according to active text editor.
  # may exist more than one active project: if you have '/a' and '/a/b' in you project
  # and you open a file '/a/b/c.txt' then '/a' and '/a/b' both are active peoject
  # if you set onlyOne=true then it only return '/a/b' (the most match one)
  # 
  # if there isn't a active text editor, return first project path
  # if there isn't a project open in atom, return undefined
  # attention! getActiveTextEditor()?.getPath() return the real path, so be careful
  getActiveProjectPath: ({onlyOne}={})->
    paths = atom.project.getPaths()
    realPaths = _.map(paths,@realPath)
    activeFilePath = atom.workspace.getActiveTextEditor()?.getPath()
    return paths[0] if not activeFilePath
    realActiveFilePath = @realPath(activeFilePath)

    legalPathIndex = (i for v,i in realPaths when realActiveFilePath.startsWith(v))
    legalPaths = (paths[v] for v,i in legalPathIndex)
    return undefined if legalPaths.length == 0
    return legalPaths[0] if legalPaths.length == 1
    if onlyOne
      legalPaths = _.sortBy(legalPaths,(o)-> -o.length)
      return legalPaths[0]
    else
      return legalPaths

  realPath: (path)->
    try
      fs.statSync(path)
      return fs.realpathSync(path)
    catch error
      return path