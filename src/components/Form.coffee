module.exports = defineComponent
  render: ->
    getReact().DOM.form
      onSubmit: ((e) ->
        e.preventDefault();
        o = {}
        for data in $(@getDOMNode()).serializeArray()
          o[data.name] = data.value
        @props.onSubmit(o)

      ).bind @
      @props.children
