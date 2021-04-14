import { ComponentFixture, TestBed } from '@angular/core/testing';

import { AnalizadoresGeneradosComponent } from './analizadores-generados.component';

describe('AnalizadoresGeneradosComponent', () => {
  let component: AnalizadoresGeneradosComponent;
  let fixture: ComponentFixture<AnalizadoresGeneradosComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ AnalizadoresGeneradosComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(AnalizadoresGeneradosComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
