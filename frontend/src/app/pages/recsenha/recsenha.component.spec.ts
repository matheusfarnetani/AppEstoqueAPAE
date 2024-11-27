import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RecsenhaComponent } from './recsenha.component';

describe('RecsenhaComponent', () => {
  let component: RecsenhaComponent;
  let fixture: ComponentFixture<RecsenhaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [RecsenhaComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(RecsenhaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
