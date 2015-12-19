import * as _ from 'lodash';
import * as fs from 'fs';

module Util{
  export let FILENAME_REGEX = /\w+[-|\w]*/;
  export let IMG_PREFIX_REGEX = /img\:\w+[-|\w]*/;

  export module Project{
    export function getProjectPaths(){
      return atom.project.getPaths();
    }

    /**
     * a atom window will contain many project, get the projects contain activity file.
     * if not open a file. return empty array.
     */
    export function getActiveProjectPaths(): string[]{
      let paths = atom.project.getPaths();
      let realPaths = _.map(paths,Path.getRealPath);
      let activityTextEditor = atom.workspace.getActiveTextEditor();
      if(activityTextEditor){
        var activityFilePath = Path.getRealPath(activityTextEditor.getPath());
      }else{
        return [];
      }

      let result = [];
      for(let path of paths){
        if(path.startsWith(activityFilePath)){
          result.push(path);
        }
      }
      return result;
    }

    export function editFile(path: string){
      atom.workspace.open(path,{});
    }
  }


  export module Path{
    export function getRealPath(path: string){
      try{
        fs.statSync(path);
        return fs.realpathSync(path);
      }catch(e){
        return path;
      }
    }
  }
}

export = Util;
