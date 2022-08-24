// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

import './jquery-setup';
import 'jquery-ui-bundle';
import './components/CategorySelector';
import './components/CompanyAutocomplete';
import ReactRailsUJS from "react_ujs";
document.addEventListener('turbo:before-visit', ()=>{
  ReactRailsUJS.unmountComponents();
})

document.addEventListener('turbo:load', ()=>{
  ReactRailsUJS.mountComponents();
  setup();
})

function setup(){
  const elements = document.querySelectorAll('input,select,textarea');
  const invalidListener = function(){ this.scrollIntoView(false); };
  for(let i = elements.length; i--;)
    elements[i].addEventListener('invalid', invalidListener);
}
