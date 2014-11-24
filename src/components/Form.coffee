qs = require "qs"

module.exports = defineComponent
  render: ->
    getReact().DOM.form
      onSubmit: ((e) ->
        e.preventDefault();
        @props.onSubmit($(@getDOMNode()).serializeObject())

      ).bind @
      @props.children
