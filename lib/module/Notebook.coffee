path = require "path"
fs = require "fs"
mkdirp = require "mkdirp"

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
      mkdirp.sync newPath
      atom.open(pathsToOpen:[newPath],newWindow:true)
      return true
    return false
