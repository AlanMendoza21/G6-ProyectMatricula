import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportematriculaComponent } from './reportematricula.component';

describe('ReportematriculaComponent', () => {
  let component: ReportematriculaComponent;
  let fixture: ComponentFixture<ReportematriculaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ReportematriculaComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ReportematriculaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
