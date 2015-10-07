util = require('../../lib/util/Util')
path = require('path')

describe "Util test", ->
  specPath = path.resolve(__dirname,'..')
  demoNotePath = path.join(specPath,'demoNote')

  describe "Util::getActiveProjectPath",->

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
