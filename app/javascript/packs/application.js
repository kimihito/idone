/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')

import Turbolinks from 'turbolinks'
import quicklink from 'quicklink/dist/quicklink.umd.js'
import feather from 'feather-icons'
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

import '../styles/application.scss'

require("@rails/ujs").start()

const application = Application.start()
const context = require.context("controllers", true, /.js$/)
application.load(definitionsFromContext(context))

import "controllers"

Turbolinks.start()
document.addEventListener('turbolinks:load', () => {
  feather.replace({'width': 18, 'height': 18})
  quicklink()
})
