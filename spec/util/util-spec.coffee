Util = require('.././util/Util')
path = require('path')
TestUtil = require('../TestUtil')
momnet = require('moment')

describe "Util test", ->
  mNotebookPath: null

  describe "Util::getActiveProjectPath",->
    specPath = path.resolve(__dirname,'..')
    demoNotePath = path.join(specPath,'demoNote')

    it "default in spec, atom will open the package spec folder as a project", ->
      expect(util.getActiveProjectPath()).toBe specPath

    it "open a file not in project, zhe active project path is undefined",->
      waitsForPromise ->
        atom.workspace.open('/x/x/x').then ->
          expect(util.getActiveProjectPath()).toBeUndefined()

    it "open a file in the project, return the project path", ->
      waitsForPromise ->
        atom.workspace.open(demoNotePath).then ->
          expect(util.getActiveProjectPath()).toBe specPath

    it "if active text editor belong to more than one project, return all fo them", ->
      atom.project.addPath(demoNotePath)
      waitsForPromise ->
        atom.workspace.open(path.join(demoNotePath,'note.json')).then ->
          expect(util.getActiveProjectPath()).toEqual [specPath,demoNotePath]

  describe "Util::getPrefixText test", ->
    _editor = null

    beforeEach ->
      waitsForPromise ->
        atom.workspace.open(momnet().format()).then ->
          _editor = atom.workspace.getActiveTextEditor()

    afterEach ->
      _editor.selectAll()
      _editor.delete()
      atom.workspace.destroyActivePaneItemOrEmptyPane()

    it "if cursor is behind a word, and word meet the regex, return the word", ->
      _editor.insertText('hello world')
      expect(Util.getPrefixText(Util.FILENAME_REGEX)).toBe 'world'
      _editor.insertText(' hello-world')
      expect(Util.getPrefixText(Util.FILENAME_REGEX)).toBe 'hello-world'

    it "test img prefix", ->
      _editor.insertText('hello world')
      expect(Util.getPrefixText(Util.IMG_PREFIX_REGEX)).toBeUndefined()
      _editor.insertText(' img:image-title')
      expect(Util.getPrefixText(Util.IMG_PREFIX_REGEX)).toBe 'img:image-title'
