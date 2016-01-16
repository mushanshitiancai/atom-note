fs = require("fs")

# Config class of notebook. 
# Deal with note.json file in notebook folder.
module.exports = 
class NotebookConfig
  version = 0.1

  @create: ({author})->
    new NotebookConfig({author:author,version:version})

  @readFromFile: (path)->
    jsonStr = fs.readFileSync(path)
    jsonObj = JSON.parse(jsonStr)
    new NotebookConfig(jsonObj)

  writeToFile: (path)->
    fs.writeFileSync(path,@getJson())

  constructor: ({@author,@version})->

  getJson: ->
    JSON.stringify(this,null,'  ') 


# jsonPath = "/Users/mazhibin/project/xxx/note.json"
# # n = new NotebookConfig(author:'mzb',version:10000009)
# # console.log n.getJson()
# # n.writeToFile(jsonPath)

# n = NotebookConfig.readFromFile(jsonPath)
# console.log n.getJson()

path = require 'path'
console.log path.join('/home','xx.jon')
