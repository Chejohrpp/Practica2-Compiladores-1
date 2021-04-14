import { Component, Host, OnInit } from '@angular/core';
import { AppComponent } from '../app.component';

@Component({
  selector: 'app-img-arbol',
  templateUrl: './img-arbol.component.html',
  styleUrls: ['./img-arbol.component.css']
})
export class ImgArbolComponent implements OnInit {

  constructor(
    @Host() private _app:AppComponent
  ) { }
  ngOnInit(): void {
  }

}
