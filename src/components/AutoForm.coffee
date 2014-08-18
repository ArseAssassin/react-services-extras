Form = require "./Form"

module.exports = defineComponent 
  getDefaultProps: ->
    formatData: (it) -> it
  setErrors: (errors) ->
    iterateChildren = ((children) ->
      for child in children
        if child.length
          iterateChildren(child)
        else
          if child.setErrors
            child.setErrors errors
    ).bind @

    iterateChildren(@props.children)
  render: ->
    Form
      onSubmit: ((data) ->
        @props.send @props.formatData(data), ((data) ->
          if data.status == 200
            @props.onSuccess(data)
          else
            @setErrors data.body.errors
        ).bind @
      ).bind @

      @props.children

