import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["industry", "institution", "department", "company", "country", "category"];
  industryTarget: HTMLInputElement;
  institutionTarget: HTMLInputElement;
  departmentTarget: HTMLInputElement;
  companyTarget: HTMLInputElement;
  countryTarget: HTMLInputElement;
  categoryTarget: HTMLInputElement;

  connect() {
    let elements = document.querySelectorAll('input,select,textarea');
    let invalidListener = function(){ this.scrollIntoView(false); };
    for(let i = elements.length; i--;)
      elements[i].addEventListener('invalid', invalidListener);

    const changeDisplay = (category:string) => {
      this.industryTarget.style.display = 'none'
      this.departmentTarget.style.display = 'none'
      this.countryTarget.style.display = 'none'
      this.companyTarget.style.display = 'none'
      this.institutionTarget.style.display = 'none'
      if(category === '學術界') {
        this.departmentTarget.style.display = 'contents'
        this.institutionTarget.style.display = 'contents'
      }else {
        this.industryTarget.style.display = 'contents'
        this.countryTarget.style.display = 'contents'
        this.companyTarget.style.display = 'contents'
      }
    }

    changeDisplay(this.categoryTarget.value);
    $(this.categoryTarget).on("change", function(e){
      changeDisplay(e.target.value);
    })

  }
}
