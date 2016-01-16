_ = require "lodash"
path = require "path"
fs = require "fs-extra"
Util = require "../util/util"
ProjectUtil = require "../util/project-util"
NotebookConfig = require "./notebook-config"
Note = require "./note"

module.exports = global.Notebook = # TEST
class Notebook
  @notebookCache: [] # TODO change to {}

  @createNotebook: (newPath,author) ->
    fs.stat newPath, (err,stat) =>
      if err?.code isnt "ENOENT"
        return Util.alert "path \"#{newPath}\" alerdy exist!"

      fs.mkdirsSync(newPath)

      # create note.json to notebook folder
      config = NotebookConfig.create(author:author)
      config.writeToFile(NotebookConfig.getConfigFilePath(newPath))

      atom.open(pathsToOpen:[newPath],newWindow:true)

  # if projectPath is a legal notebook path return projectPath,else return false
  @isLegalNotebookPath: (projectPath)->
    return false if not projectPath
    configFilePath = NotebookConfig.getConfigFilePath(projectPath)
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
  @getActiveNotebookPath: ()->
    activeProjectPath = ProjectUtil.getActiveProjectPath(onlyOne:true)
    return activeProjectPath if @isLegalNotebookPath(activeProjectPath)
    allNotebookPath = @getAllNotebookPathInProject()
    if allNotebookPath
      return allNotebookPath[0]
    return undefined

  @getActiveNotebook: ()->
    activeNotebookPath = @getActiveNotebookPath()
    return undefined if not activeNotebookPath
    notebook = @getNotebookFromCache(activeNotebookPath)
    if notebook
      return notebook
    else
      return new Notebook(activeNotebookPath)

  @getAllNotebookPathInProject: ()->
    paths = atom.project.getPaths()
    return undefined if not paths
    (aPath for aPath in paths when @isLegalNotebookPath(aPath))

  @addNotebookToCache: (notebook)->
    # TODO prevent repeat push
    @notebookCache.push(notebook)

  @getNotebookFromCache: (path='')->
    if not path
      return @notebookCache
    else
      return _.first (notebook for notebook in @notebookCache when notebook.path is path)


  constructor: (@path)->
    if typeof @path isnt 'string' 
      throw new TypeError("Notebook constructor: path must be a string.")

    @config = NotebookConfig.readFromFile(NotebookConfig.getConfigFilePath(@path))

    # add instance to cache
    @constructor.addNotebookToCache(this)

  addNote: (args={title:''})->
    args.projectPath = @path
    Note.createNote(args)

  openTodayJournal: ->
