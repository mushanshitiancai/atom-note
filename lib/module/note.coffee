fs = require "fs"
path = require "path"
Util = require "../util/util"
NoteHeader = require "./note-header"

module.exports = 
class Note
  @noteCache = {}

  @createNote: ({notePath,title,projectPath})->
    notePath ?= path.join(projectPath,title) # TODO fix the logic of note file name and verify title char
    try
      fs.statSync(notePath)
      Util.alert("create note:path '#{notePath}' alerdy exist.")
    catch e
      header = new NoteHeader(title:title)
      yamlStr = header.toYAML(withDashed:true)

      fs.writeFileSync(notePath,yamlStr)
      
    

  constructor: ()->
