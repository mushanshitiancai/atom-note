
module Logger{
  let isDebug = true;
  let perfix = 'atom-note: ';

  export function debug(any){
    if(isDebug)
      console.log(perfix+any);
  }

  export let d = debug;
}

export = Logger;
