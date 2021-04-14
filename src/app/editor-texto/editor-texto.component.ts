import { Component, Host, OnInit } from '@angular/core';
import { AppComponent } from '../app.component';

@Component({
  selector: 'app-editor-texto',
  templateUrl: './editor-texto.component.html',
  styleUrls: ['./editor-texto.component.css']
})
export class EditorTextoComponent  {

  constructor(
    @Host() private _app: AppComponent
  ){  }

  parser = require('../reglasGram/gramatica.js');
  expr:String;
  array: {'id':String,'cont':any}[] = []; 
  listaErrores:String[] =[];

  recibirTexto(form){
    this.array = this.parser.parse(this.expr);
    for (let index = 0; index < this.array.length; index++) {
      const element = this.array[index];
      if (element.id == 'listaErrores') {
        this.listaErrores = element.cont
      }      
    }
    if (this.listaErrores.length == 0) {
      this._app.addArrayListAn(this.expr)
      this._app.activarArbol = true;
    }else{
      this._app.activarArbol = false;
    }    
  }
}
