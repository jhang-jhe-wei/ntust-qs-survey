import { Controller } from "stimulus";
import axios from "axios";

export default class extends Controller {
  static targets = ["industry", "academic", "category", "company"];
  industryTargets: HTMLInputElement[];
  academicTargets: HTMLInputElement[];
  categoryTarget: HTMLInputElement;
  companyTarget: HTMLInputElement;

  connect() {
    this.changeVisible();
    this.setupAutocomplete();
    this.setupInvalidScroller();
  }

  setupAutocomplete(){
    $(this.companyTarget).autocomplete({
      source: function(request, callback){
        axios.get("/autocompletes/company_name", {
          params: {
            q: request.term
          }
        }).then((response) => {
          callback(response.data);
        });
      }
    });
  }

  setupInvalidScroller(){
    let elements = document.querySelectorAll('input,select,textarea');
    let invalidListener = function(){ this.scrollIntoView(false); };
    for(let i = elements.length; i--;)
      elements[i].addEventListener('invalid', invalidListener);
  }

  changeVisible() {
    this.industryTargets.forEach(target => target.style.display = 'none')
    this.academicTargets.forEach(target => target.style.display = 'none')
    if(this.categoryTarget.value === '學術界') {
      this.academicTargets.forEach(target => target.style.display = 'contents')
    }else {
      this.industryTargets.forEach(target => target.style.display = 'contents')
    }
  }
}
