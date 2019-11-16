/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import Turbolinks from 'turbolinks'
import quicklink from 'quicklink/dist/quicklink.umd.js'
import feather from 'feather-icons'
import Lazyload from 'vanilla-lazyload'
import 'whatwg-fetch'
import '@webcomponents/custom-elements'
import 'details-dialog-element'
import '@github/include-fragment-element'
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

import '../styles/application.scss'

import "core-js/stable"
import "regenerator-runtime/runtime"

require('intersection-observer')
require("@rails/ujs").start()
require("@rails/activestorage").start()

Turbolinks.start()

const application = Application.start()
const context = require.context("controllers", true, /.(js|.ts)$/)
application.load(definitionsFromContext(context))

import "controllers"
document.addEventListener('turbolinks:load', () => {
  new Lazyload()
  feather.replace({'width': 18, 'height': 18})
  quicklink({
    ignores: [
      (uri, elem) => elem.dataset.method == 'delete'
    ]
  })
})
