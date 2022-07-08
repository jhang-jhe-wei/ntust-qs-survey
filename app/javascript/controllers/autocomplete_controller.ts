import { Controller } from "stimulus";
import axios from "axios";

export default class extends Controller {
  companyTarget: HTMLInputElement;
  static targets = ["company"];

  connect() {
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
}
