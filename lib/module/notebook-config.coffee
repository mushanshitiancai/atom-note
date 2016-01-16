fs = require("fs")
path = require("path")

# Config class of notebook. 
# Deal with note.json file in notebook folder.
module.exports = 
class NotebookConfig
  version = 0.1

  @getConfigFilePath: (notebookPath)->
    return path.join(notebookPath,'note.json')

  @create: ({author})->
    new NotebookConfig({author:author,version:version})

  @readFromFile: (filePath)->
    jsonObj = readJsonFile(filePath)
    return undefined if not jsonObj
    new NotebookConfig(jsonObj)

  @isLegalNotebookConfig: (filePath)->
    return true if readJsonFile(filePath)
    return false

  writeToFile: (filePath)->
    fs.writeFileSync(filePath,@getJson())

  constructor: ({@author,@version})->

  getJson: ->
    JSON.stringify(this,null,'  ') 



readJsonFile = (filePath)->
  try
    jsonStr = fs.readFileSync(filePath)
    jsonObj = JSON.parse(jsonStr)
    return jsonObj
  catch e
    return undefined
  


# jsonPath = "/Users/mazhibin/project/xxx/note.json"
# # n = new NotebookConfig(author:'mzb',version:10000009)
# # console.log n.getJson()
# # n.writeToFile(jsonPath)

# n = NotebookConfig.readFromFile(jsonPath)
# console.log n.getJson()

# path = require 'path'
# console.log path.join('/home','xx.jon')

# console.log JSON.parse('{')
