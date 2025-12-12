import { TestBed } from '@angular/core/testing';

import { VotosTs } from './votos.ts';

describe('VotosTs', () => {
  let service: VotosTs;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(VotosTs);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
