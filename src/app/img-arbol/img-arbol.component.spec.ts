import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ImgArbolComponent } from './img-arbol.component';

describe('ImgArbolComponent', () => {
  let component: ImgArbolComponent;
  let fixture: ComponentFixture<ImgArbolComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ImgArbolComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ImgArbolComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
