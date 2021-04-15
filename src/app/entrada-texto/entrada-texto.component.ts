import { Component, Host, OnInit } from '@angular/core';
import { AppComponent } from '../app.component';

@Component({
  selector: 'app-entrada-texto',
  templateUrl: './entrada-texto.component.html',
  styleUrls: ['./entrada-texto.component.css']
})
export class EntradaTextoComponent implements OnInit {

  constructor(
    @Host() private _app: AppComponent
  ) { }

  ngOnInit(): void {
  }
  listaErrores: String[] =[];
  gramatica:any = this._app.gramaticaActual;
  entradaTrue:boolean = false;

  analizarTexto(form){
  this.gramatica = this._app.gramaticaActual;
    this.listaErrores = [];
    const texto = form.value.txtEntrada;
    const Parser = require("jison").Parser;
    const parser = new Parser(this.gramatica);
    try {
      console.log('Resultado del parser es: ' + parser.parse(texto));
      this.entradaTrue = true;
    } catch (error) {
      this.listaErrores.push(error);
      this.entradaTrue = false;
    }
  }

}
