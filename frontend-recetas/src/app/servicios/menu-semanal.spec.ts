import { TestBed } from '@angular/core/testing';

import { MenuSemanal } from './menu-semanal';

describe('MenuSemanal', () => {
  let service: MenuSemanal;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MenuSemanal);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
