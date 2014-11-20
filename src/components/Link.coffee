module.exports = defineComponent
  subscribe:
    navigate:   "NavService#navigate"

  onClick: (e) ->
    if @props.onClick
      @props.onClick(e)
    else
      e.preventDefault();
      @services.navigate(@getHref())
    
  getHref: ->
    @props.href

  render: ->
    getReact().DOM.a Object.assign {}, @props,
      href: @getHref()
      onClick: @onClick
      @props.children
