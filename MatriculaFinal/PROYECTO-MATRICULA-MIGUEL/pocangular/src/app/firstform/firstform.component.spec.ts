import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FirstformComponent } from './firstform.component';

describe('FirstformComponent', () => {
  let component: FirstformComponent;
  let fixture: ComponentFixture<FirstformComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [FirstformComponent]
    });
    fixture = TestBed.createComponent(FirstformComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
