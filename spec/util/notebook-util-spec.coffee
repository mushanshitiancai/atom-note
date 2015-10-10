NotebookUtil = require('../../lib/util/NotebookUtil')
TestUtil     = require('../TestUtil')
moment       = require('moment')
path         = require('path')
fs           = require('fs-extra')

describe "NotebookUtil test", ->
  mNotebookPath = null

  ###
  # when face a illegal project
  ###
  describe "when face a illegal project", ->
    beforeEach ->
      mNotebookPath = TestUtil.createNotebook()
      atom.project.setPaths([mNotebookPath])

    it "open correct path",->
      expect(atom.project.getPaths()).toEqual [TestUtil.getNotebook()]

    describe "NotebookUtil::isLegalNotebook test", ->
      it "before init zhe empty folder is not a valid notebook folder",->
        expect(NotebookUtil.isLegalNotebook(mNotebookPath)).toBe false

    it "NotebookUtil::getJournalPath test", ->
      expect(NotebookUtil.getJournalPath()).toBeUndefined()

    it "NotebookUtil::openJournal test",->
      pre = atom.workspace.getActiveTextEditor()?.getPath()
      expect(NotebookUtil.openJournal()).toBeUndefined()
      expect(atom.workspace.getActiveTextEditor()?.getPath()).toBe(pre)

    afterEach ->
      TestUtil.removeNotebook()

  ###
  # when face a legal atom-note project
  ###
  describe "when face a legal atom-note project",->
    beforeEach ->
      mNotebookPath = TestUtil.createNotebook()
      TestUtil.initNotebook()
      atom.project.setPaths([mNotebookPath])

    describe "NotebookUtil::isLegalNotebook test", ->
      it "if the folder contain a note.json file, it would be considered as a legal atom-note project",->
        expect(NotebookUtil.isLegalNotebook(mNotebookPath)).toBe mNotebookPath

    describe "NotebookUtil::getActiveNotebookPath test", ->
      it "when not open a file, getActiveNotebookPath return the first project",->
        expect(NotebookUtil.getActiveNotebookPath()).toBe(mNotebookPath)

      it "when not open a file, getActiveNotebookPath return the first project,
          if first project isn't a legal project, return false",->
        atom.project.setPaths(['/',mNotebookPath])
        expect(NotebookUtil.getActiveNotebookPath()).toBe(false)

      it "when open a file, check whether the project contain this file legal, if yes return path", ->
        atom.project.setPaths(['/',mNotebookPath])
        waitsForPromise ->
          atom.workspace.open(TestUtil.getNotebookJsonFilePath()).then ->
            expect(NotebookUtil.getActiveNotebookPath()).toBe(mNotebookPath)

      it "when open a file, check whether the project contain this file legal, if false reutrn false", ->
        atom.project.setPaths(['/'])
        waitsForPromise ->
          atom.workspace.open(TestUtil.getNotebookJsonFilePath()).then ->
            expect(NotebookUtil.getActiveNotebookPath()).toBe(false)

    it "NotebookUtil::getJournalPath test", ->
      d = new Date()
      expect(NotebookUtil.getJournalPath()).toBe(TestUtil.getJournalPath())

    it "NotebookUtil::openJournal test",->
      waitsForPromise ->
        NotebookUtil.openJournal().then ->
          expect(atom.workspace.getActiveTextEditor()?.getPath())
            .toBe(fs.realpathSync(TestUtil.getJournalPath()))

    afterEach ->
      TestUtil.removeNotebook()
