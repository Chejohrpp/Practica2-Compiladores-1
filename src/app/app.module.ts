import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import {FormsModule} from '@angular/forms';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { EditorTextoComponent } from './editor-texto/editor-texto.component';
import { AnalizadoresGeneradosComponent } from './analizadores-generados/analizadores-generados.component';
import { ImgArbolComponent } from './img-arbol/img-arbol.component';

@NgModule({
  declarations: [
    AppComponent,
    EditorTextoComponent,
    AnalizadoresGeneradosComponent,
    ImgArbolComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
