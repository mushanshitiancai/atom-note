// import * as atom from "atom";
import view = require('./view');
var $ = view.$;
import sp = require("atom-space-pen-views");

interface InputViewOptions{
  title:string,
  oldValue:string,
  onCommit: (newValue:string)=>any,
  onCancel: ()=>any
}

class InputView extends view.View<InputViewOptions>{

  static content(){
    return this.div({class:'fuck'},()=>{
      this.div({class: 'block'},()=>{
        this.span({class:'heheheeh'},'hello');
      });

      this.subview('fuck',new sp.TextEditorView({mini:true}));
    });

  }

  test(){

  }

}

export = InputView;
