NoteUtil = require('../../lib/util/NoteUtil')
TestUtil = require('../TestUtil')

describe "NoteUtil test", ->
  mNotebookPath = null

  beforeEach ->
    mNotebookPath = TestUtil.createNotebook()
    atom.project.setPaths([mNotebookPath])

  afterEach ->
    TestUtil.removeNotebook()

  it "NoteUtil::initNote test", ->
    # tested from NotebookUtil::openJournal
