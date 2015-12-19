//DefinitelyTyped项目中的atom.d.ts对应的atom版本比较旧，所以需要自己扩展一下
//// <reference path="./typings/tsd.d.ts"/>

declare module "atom" {

}

declare module AtomCore {
  	interface IProject{
      getPaths():string[];
    }
}

declare module 'atom-space-pen-views' {
    import atom = require('atom');
    export class SelectListView extends atom.SelectListView { }
    export class ScrollView extends atom.ScrollView { }
    export class View extends atom.View { }
    export var $: JQueryStatic;

    export class TextEditorView {
      constructor(option:{mini?:boolean,placeholderText?:string});
      model: AtomCore.IEditor;
    }
}

/** Provided by the atom team */
interface String {
    startsWith(str: string): boolean;
    endsWith(str: string): boolean;
}
