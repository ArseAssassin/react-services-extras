module.exports = defineComponent
  subscribe:
    navigate:   "NavService#navigate"

  onClick: (e) ->
    if @props.onClick
      @props.onClick(e)
    else
      e.preventDefault();
      @state.navigate(@getHref())
    
  getHref: ->
    @props.href

  render: ->
    @transferPropsTo getReact().DOM.a
      href: @getHref()
      onClick: @onClick
      @props.children