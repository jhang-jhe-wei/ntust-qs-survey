// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'

import './components/CategorySelector'
import './components/CompanyAutocomplete'
import './components/TableExporter'
import ReactRailsUJS from 'react_ujs'
document.addEventListener('turbo:before-visit', () => {
  ReactRailsUJS.unmountComponents()
})

document.addEventListener('turbo:load', () => {
  ReactRailsUJS.mountComponents()
  setup()
})

function setup () {
  const elements = document.querySelectorAll('input,select,textarea')
  const invalidListener = function () { this.scrollIntoView(false) }
  elements.forEach(element => element.addEventListener('invalid', invalidListener))
}
