
module.exports =
class Editor
  listLine: /^(\s*)([-+*])(\s+).*$/;

  constructor: ->

  insertNewLine: ->
    console.log('new line')
    editor = atom.workspace.getActiveTextEditor();
    line = editor.lineTextForBufferRow(editor.getCursorBufferPosition().row)

    if matchs = @listLine.exec(line)
      console.log 'insert'
      editor.insertText("\n#{matchs[1]}#{matchs[2]} ")
