path = require "path"
fs = require "fs-extra"
Util = require "../util/util"
NotebookConfig = require "./notebook-config"

module.exports=
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

  openTodayJournal: ->
