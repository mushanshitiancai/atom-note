import * as _ from 'lodash';
import * as fs from 'fs';
import * as path from 'path';
import * as Util from './Util';

module NotebookUtil{
  let metaFile = 'note.json';

  function isLegalNotebook(projectPath: string) :boolean{
    try{
      fs.statSync(path.join(projectPath,metaFile));
      return true;
    }catch(e){
      return false;
    }
  }

  export function getActiveNotebook(): string{
    let paths = Util.Project.getActiveProjectPaths();
    for(let path of paths){
      if(isLegalNotebook(path)){
        return path;
      }
    }
  }
}

export = NotebookUtil;
