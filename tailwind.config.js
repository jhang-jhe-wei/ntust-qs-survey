module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      backgroundImage: {
        'qs-survey': "url('/qs-survey.png')",
      },
      gridTemplateColumns: {
        'min-contect-and-auto': 'max-content auto'
      }
    }
  }
}
