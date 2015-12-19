import * as _atom from 'atom';

// import * as InputView from './views/InputView';
import InputView = require('./views/InputView');

export interface PackageState {
}


export function activate(state: PackageState){
  atom.commands.add('atom-text-editor','atom-note:test',(event) => {
    // alert('fuck');

    let view = new InputView({});
    atom.workspace.addModalPanel({item:view,visible:true});
  });

}

export function deactivate(){

}

export function serialize(){

}
