var tailwindcss = require('tailwindcss')
module.exports = {
  plugins: [
    tailwindcss('app/javascript/styles/tailwindcss.js'),
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexbox: 'no-2009'
      },
      stage: 3
    })
  ]
}
