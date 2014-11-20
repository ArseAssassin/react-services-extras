dom = getReact().DOM

module.exports = defineComponent
  subscribe:
    path: "NavService#path"

  displayName: "Router"

  getDefaultProps: ->
    error: ->
      dom.div null,
        dom.h1 null,
          "404"
  render: ->
    path = @services.path
    page = []

    for child in [].concat @props.children
      resource = child.props.resource.match(path)
      if resource
        page.push child.props.handler.call(child, resource.parse(@services.path))
        if !@props.multiple
          break

    if page.length == 0
      page.push @props.error()

        
    dom.div null,
      page
