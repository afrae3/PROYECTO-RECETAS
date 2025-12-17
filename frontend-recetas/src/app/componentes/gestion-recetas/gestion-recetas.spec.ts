import { ComponentFixture, TestBed } from '@angular/core/testing';

import { GestionRecetas } from './gestion-recetas';

describe('GestionRecetas', () => {
  let component: GestionRecetas;
  let fixture: ComponentFixture<GestionRecetas>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [GestionRecetas]
    })
    .compileComponents();

    fixture = TestBed.createComponent(GestionRecetas);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
