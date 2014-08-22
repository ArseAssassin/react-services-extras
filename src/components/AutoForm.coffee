Form = require "./Form"

module.exports = defineComponent 
  getDefaultProps: ->
    formatData: (it) -> it
  getInitialState: ->
    errors: {}
  setErrors: (errors) ->
    @setState
      errors: errors
  render: ->
    Form
      onSubmit: ((data) ->
        @setErrors({})
        @props.send @props.formatData(data), ((data) ->
          if data.status == 200
            @props.onSuccess(data)
          else
            @setErrors data.body.errors
        ).bind @
      ).bind @

      @props.children.map ((child) ->
        if child.call
          child(
            @state.errors
          )
        else
          child
      ).bind @

