module.exports = defineComponent
  handler: (params) ->
    @props.handler(params)
  render: ->
    dom.div null,
      @props.children
