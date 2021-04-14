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
  arrayListAnCont: {'id':String, 'cont':String}[] = this._app.arrayListAnCont
  mostrarCont:boolean = false;
  contMostar:String;

  mostrarText(id:String){
    if (this.mostrarCont) {
      this.mostrarCont =false
    }else{
      for (let index = 0; index < this.arrayListAnCont.length; index++) {
        const element = this.arrayListAnCont[index];
        if (element.id == id) {
          this.contMostar = element.cont
          this.mostrarCont = true
        }      
      }
    }        
  }

}
