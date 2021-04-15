import { Component, Host, Input, OnInit } from '@angular/core';
import { AppComponent } from '../app.component';

@Component({
  selector: 'app-analizadores-generados',
  templateUrl: './analizadores-generados.component.html',
  styleUrls: ['./analizadores-generados.component.css']
})
export class AnalizadoresGeneradosComponent implements OnInit {


  constructor(
    @Host() private _app: AppComponent
  ) { }

  ngOnInit(): void {
  }
  arrayListAnCont: {'id':String, 'cont':String, 'gramatica': any}[] = this._app.arrayListAnCont
  mostrarCont:boolean = false;
  gramActual:String;
  contMostar:String;

  mostrarText(id:String){
    if (this.mostrarCont) {
      this.mostrarCont =false
    }else{
      const el = this.arrayListAnCont.find(x=>x.id == id);
      this.contMostar = el.cont;
      this.mostrarCont =true;
      /*for (let index = 0; index < this.arrayListAnCont.length; index++) {
        const element = this.arrayListAnCont[index];
        if (element.id == id) {
          this.contMostar = element.cont
          this.mostrarCont = true
        }      
      }*/
    }        
  }
  cambiarGram(id:String){
    const el = this.arrayListAnCont.find(x=>x.id == id);
    this._app.gramaticaActual = el.gramatica;
    this.gramActual = el.id;
    this._app.activarEntradaTxt = true;
  }

}
