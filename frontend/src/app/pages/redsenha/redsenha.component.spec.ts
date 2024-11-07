import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RedsenhaComponent } from './redsenha.component';

describe('RedsenhaComponent', () => {
  let component: RedsenhaComponent;
  let fixture: ComponentFixture<RedsenhaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [RedsenhaComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(RedsenhaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
