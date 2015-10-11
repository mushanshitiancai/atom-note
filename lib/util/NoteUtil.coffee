fs   = require('fs-extra')
path = require('path')
Util = require('./Util')
NotebookUtil = require('./NotebookUtil')
moment = require('moment')
yaml = require('js-yaml')

module.exports = NoteUtil =

  initNote: (notePath,title,date=new Date())->
    return unless notePath
    try
      fs.statSync(notePath)
      # note is existed
    catch error
      headerStr = "---\n"+yaml.safeDump(@generateNoteHeader(date))+"---\n\n"
      headerStr += "# #{title}\n"
      fs.outputFileSync(notePath,headerStr)

  generateNoteHeader: (date=new Date())->
    return date:moment(date).format()

  getActiveNoteFolder: ()->
    filePath = Util.getActiveTextEditorPath()
    folderName = path.basename(filePath).split('.')[0]
    folderPath = path.join(path.dirname(filePath),folderName)
    return folderPath

  ensureActiveNoteFolder: ()->
    folderPath = @getActiveNoteFolder()
    fs.ensureDirSync(folderPath)
    return folderPath

  insertImage: (e)->
    if not activeFilePath = Util.getActiveTextEditorPath()
      e.abortKeyBinding()
      return

    # check if a image in clipboard
    clipboard = require('clipboard')
    img = clipboard.readImage();
    if not img or img.isEmpty()
      e.abortKeyBinding()
      return
    console.log img

    # if user select some text, then use the text as image filename
    if not imgName = Util.getSelectedText()
      prefixRet = Util.getPrefixText(Util.IMG_PREFIX_REGEX)
      if not prefixRet
        e.abortKeyBinding()
        return
      {text:imgName,range:imgNamePrefixRange} = prefixRet
      if not imgName = imgName?.split(':')[1]
        # alert('if you want to paste image,
        #       you can select some text as image title and then paste.or you can input img:image-name and then enter tab')
        e.abortKeyBinding()
        return

    folderPath = @ensureActiveNoteFolder()
    try
      folderStats = fs.statSync(folderPath)
    catch error
      fs.ensureDirSync(folderPath)
      try
        folderStats = fs.statSync(folderPath)
      catch error
        alert('create folder fail!')

    if folderStats and folderStats.isDirectory()
      imgPath = path.resolve(folderPath,imgName+'.png')
      relativeImgPath = path.relative(path.dirname(activeFilePath),imgPath)
      fs.outputFileSync(imgPath,img.toPng())

      if imgNamePrefixRange
        Util.deleteBufferRange(imgNamePrefixRange)
      Util.insertText("!["+imgName+"]("+relativeImgPath+")")
