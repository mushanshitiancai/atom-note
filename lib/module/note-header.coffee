yaml = require('js-yaml')

# header of a note. 
# Base on YAML. Reference to Jeklly(http://jekyllrb.com/docs/frontmatter/)
module.exports = 
class NoteHeader

  @fromYAML: (yamlStr)->
    params = yaml.safeLoad(yamlStr)
    return new NoteHeader(params)

  constructor: ({@title,@date})->
    @date ?= new Date()

  toYAML: ({withDashed})->
    yamlStr = yaml.safeDump(this)
    if withDashed
      return "---\n#{yamlStr}---\n"
    else
      return yamlStr

