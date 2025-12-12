import { Component, inject, signal, Signal, TemplateRef, WritableSignal } from '@angular/core';
import { VotesService } from './services/votes';
import { Contestant } from './services/contestant-interface'
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-root',
  templateUrl: './app.html',
  styleUrl: './app.css',
  imports: [],
  standalone: true,
})

export class App {
  readonly contestants: Signal<Array<Contestant> | null>
  readonly totalVote: WritableSignal<Array<any> | null> = signal([])
  readonly toVote: WritableSignal<string> = signal("")
  readonly votedForPercent: WritableSignal<number> = signal(0);
	private modalService: any = inject(NgbModal);
	closeResult: WritableSignal<string> = signal('');

  constructor(private service: VotesService) {
    this.contestants = this.service.getContestants()
  }

  castVote(content: TemplateRef<any>, stats: TemplateRef<any>, id: number): void {
    this.toVote.set(this.findContestant(id)!.name || "")
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title'}).result.then(
      (result: boolean) => {
        if (result) {
          this.service.postVote(id).subscribe(() => {
            this.service.getTotalVote().subscribe((arr) => {
              this.totalVote.set(arr)
              this.votedForPercent.set(this.calculatePercentage(id))
            })
            this.modalService.open(stats)
          })
        }
      }
    );
  }

  findContestant(idx: number): Contestant | undefined {
    return this.contestants()?.find((x) => x.id === idx)
  }

  calculatePercentage(idx: number): number {
    let [c1, c2] = [this.totalVote()![0], this.totalVote()![1]]
    let total = Number(c1.vote_count) + Number(c2.vote_count);
    if (c1.id === idx) {
      return Number(c1.vote_count) / total * 100
    }
    return Number(c2.vote_count) / total * 100
  }

  openAdminModal(content: TemplateRef<any>): void {
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title'});
  }
}
