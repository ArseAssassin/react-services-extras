module.exports = defineComponent
  displayName: "Route"
  handler: (params) ->
    @props.handler(params)
  render: ->
    dom.div null,
      @props.children
