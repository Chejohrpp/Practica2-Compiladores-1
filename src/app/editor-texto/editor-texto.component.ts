import { Component, Host } from '@angular/core';
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
  listaTerminales: {'id':String,'cont':any}[] = []; 
  listaNoTerminales : String[] = [];
  symInicial: String;
  listaProducciones: {'id':String,'cont':String[] }[] = [];

  recibirTexto(form){
    this.listaErrores = [];
    this.listaNoTerminales = [];
    this.listaTerminales = [];
    this.symInicial = undefined;
    this.listaProducciones = [];
    this.array = [];
    try {
      this.array = this.parser.parse(form.value.txt);
    } catch (error) {
      this.listaErrores.push(error) 
    }    
    for (let index = 0; index < this.array.length; index++) {
      const element = this.array[index];
      if (element.id == 'listaErrores') {
        this.listaErrores = element.cont
      }else if(element.id == 'listaTerminales'){
        this.listaTerminales = element.cont
      } else if(element.id == 'listaProducciones'){
        this.listaProducciones = element.cont;
      }else if(element.id == 'listaNoTerminales'){
        this.listaNoTerminales = element.cont
      }else if(element.id == 'symInicial'){
        this.symInicial = element.cont;
      }            
    }
    if (this.listaErrores.length == 0) {
      this.verificarDatos(); 
    }
    if (this.listaErrores.length == 0) { 
      //this.verDatos();
      let varGram = this.gramaticaEstrucurada();
      if (this.listaErrores.length == 0) {
        this._app.addArrayListAn(form.value.txt,varGram);
      }      
    }
  }

  verDatos(){
    console.log('terminales: ')
    for (let index = 0; index < this.listaTerminales.length; index++) {
      const element = this.listaTerminales[index];
      console.log(element.id + ' : ' + element.cont)      
    }
    console.log('No terminales: ')
    for (let index = 0; index < this.listaNoTerminales.length; index++) {
      const element = this.listaNoTerminales[index];
      console.log(element)      
    }
    console.log('Symbol inicial: ' + this.symInicial)
    console.log('Producciones: ')
    for (let index = 0; index < this.listaProducciones.length; index++) {
      const element = this.listaProducciones[index];
      console.log(element.id + ' : ' + element.cont) 
       let arr = element.cont;    
      for (let index = 0; index < arr.length ; index++) {
        const element = arr[index];
        console.log('index: ' + index + ', contenido: ' + element)        
      }
    }
  }

  verificarDatos(){
    this.verificarSymInicial();
    this.verificarProducciones();
        
  }

  verificarSymInicial(){
    for (let index = 0; index < this.listaNoTerminales.length; index++) {
      const element = this.listaNoTerminales[index];
      if (element == this.symInicial) {
        return true;
      }      
    }    
    this.listaErrores.push('El simbolo inicial: ' + this.symInicial + ' No esta declarado');
    return false;
  }

  verificarProducciones(){
      for (let index = 0; index < this.listaProducciones.length; index++) {
        const element = this.listaProducciones[index];
        let id: String = this.listaNoTerminales.find(x=>x == element.id);
        if (id == undefined) {
          this.listaErrores.push('La produccion: ' + element.id + ' de las producciones no esta declarada')
        }
         let arr = element.cont;    
        for (let index = 0; index < arr.length ; index++) {
          const elementProd = arr[index];
          if (elementProd != '|') {
            if (elementProd.startsWith('%')) {
              if ( this.listaNoTerminales.find(x=>x == elementProd) == undefined) {
                this.listaErrores.push('La derivacion ' + elementProd +' de la produccion: ' + element.id +
                 ' No esta declarada ')
              }
            }else{
              if ( this.listaTerminales.find(x=>x.id == elementProd) == undefined) {
                this.listaErrores.push('La derivacion ' + elementProd +' de la produccion: ' + element.id +
                 ' No esta declarada ')
              }
            }

          }
        }
      }
    }

    gramaticaEstrucurada(): any {
    //producciones
    let producciones = '';
    for (let index = 0; index < this.listaProducciones.length; index++) {
      const element = this.listaProducciones[index];
      producciones += '\"'+element.id+'\" : [\n';
       let arr = element.cont;    
      for (let index = 0; index < arr.length ; index++) {
        const element = arr[index];
        if (index == 0) {
          producciones += '\"';
        }
        if (element != '|') {
          producciones += ' ' + element
        }else{
          producciones += '\",\n\"'
        }
        if (index+1 == arr.length) {
          producciones += '\"'
        }    
      }
      producciones += '\n]'
      if (index+1 != this.listaProducciones.length) {
        producciones += ',\n'
      }
    }

    //lexerGram
    let lexerGramar = '';
    for (let index = 0; index < this.listaTerminales.length; index++) {
      const element = this.listaTerminales[index];
      lexerGramar += '[\"'+element.cont+'\",\"return \''+element.id+'\';\"]';
      if (index+1 != this.listaTerminales.length) {
        lexerGramar += ',\n';
        //gramarDinamic.lex.rules.push( [element.cont, "return '" + element.id +"';"],)
      }else{
        //gramarDinamic.lex.rules.push( [element.cont, "return '" + element.id +"';"])
      }
    }
    let omitirEspacios = '["\\\\s+", "/* skip whitespace */"],\n'
    let gramString = " {\n \"lex\":{\n  \"rules\" : [\n"+omitirEspacios +lexerGramar+"\n]\n},\n\"start\" : \""+this.symInicial+"\",\n \"bnf\":{\n"+producciones+"\n}\n}";
    console.log(gramString);
    let gramObjt = JSON.parse(gramString);
    try {
      const Parser = require("jison").Parser;
      const parser = new Parser(gramObjt);
    } catch (error) {
      this.listaErrores.push(error);
    }
    return gramObjt;    
  }
}
