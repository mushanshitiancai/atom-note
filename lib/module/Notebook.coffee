path = require "path"
fs = require "fs-extra"

module.exports=
class Notebook

  initialize:->

  # create a new Notebook
  create: (newPath)->
    try
      stats = fs.lstatSync(newPath)
      alert "foder existed!"
    catch
      # folder doesn't exist
      fs.mkdirsSync(newPath)
      atom.open(pathsToOpen:[newPath],newWindow:true)
      return true
    return false

  openTodayJournal: ->
