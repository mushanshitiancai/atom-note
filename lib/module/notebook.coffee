path = require "path"
fs = require "fs-extra"
Util = require "../util/util"
ProjectUtil = require "../util/project-util"
NotebookConfig = require "./notebook-config"

module.exports = global.Notebook = 
class Notebook

  @createNotebook: (newPath,author) ->
    fs.stat newPath, (err,stat) =>
      if err?.code isnt "ENOENT"
        return Util.alert "path \"#{newPath}\" alerdy exist!"

      fs.mkdirsSync(newPath)

      # create note.json to notebook folder
      configPath = path.join(newPath,'note.json')
      config = NotebookConfig.create(author:author)
      config.writeToFile(configPath)

      atom.open(pathsToOpen:[newPath],newWindow:true)

  # if projectPath is a legal notebook path return projectPath,else return false
  @isLegalNotebookPath: (projectPath)->
    return false if not projectPath
    configFilePath = path.join(projectPath,'note.json');
    try
      fs.statSync(configFilePath)
      isLegalConfigFile = NotebookConfig.isLegalNotebookConfig(configFilePath)
      if isLegalConfigFile 
        return projectPath 
      else 
        return false
    catch error
      return false

  # if active file is in a notebook, return this notebook, else return first notebook in project paths.
  # if there is't a notebook in project paths, reutrn undefined
  @getActiveNotebook: ()->
    activeProjectPath = ProjectUtil.getActiveProjectPath(onlyOne:true)
    return activeProjectPath if @isLegalNotebookPath(activeProjectPath)
    allNotebookPath = @getAllNotebookPathInProject()
    if allNotebookPath
      return allNotebookPath[0]
    return undefined

  @getAllNotebookPathInProject: ()->
    paths = atom.project.getPaths()
    return undefined if not paths
    (aPath for aPath in paths when @isLegalNotebookPath(aPath))





  openTodayJournal: ->
