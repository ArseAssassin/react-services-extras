defineService = require("react-services").defineService

Service = defineService "DOMService", ->
  document: -> document
  window: -> window
  history: -> history
