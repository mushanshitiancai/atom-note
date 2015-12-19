import * as _ from 'lodash';
import * as fs from 'fs-extra';
import * as path from 'path';
import * as Util from './Util';
import * as Logger from './Logger';
import * as yaml from 'js-yaml';
import * as moment from 'moment';

module NoteUtil{

  export function initNote(notePath: string,title: string,date = new Date()){
    if(!notePath) return;

    try{
      let stats= fs.statSync(notePath);
      if(stats.size == 0){
        _initNote(notePath,title,date);
      }else{
        Logger.d('note existed and no empty:'+notePath);
      }
    }catch(e){
      _initNote(notePath,title,date);
    }
  }

  function _initNote(notePath: string,title: string,date = new Date()){
    let headerStr = "---\n"+yaml.safeDump(generateNoteHeader(date))+"---\n\n";
    headerStr += "# "+title+"\n";
    fs.outputFileSync(notePath,headerStr);
  }

  function generateNoteHeader(date=new Date()){
    return {
      date: moment(date).format()
    }
  }
}

export = NoteUtil;
