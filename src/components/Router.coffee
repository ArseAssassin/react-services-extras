dom = getReact().DOM

module.exports = require("react-services").defineComponent
  subscribe:
    path: "NavService#path"

  getDefaultProps: ->
    error: ->
      dom.div null,
        dom.h1 null,
          "404"
  render: ->
    path = @state.path
    matches = (resource) ->
      if resource.match
        if resource.match(path)
          resource
      else 
        for k, subResource of resource
          if k != "_path"
            r = matches(subResource)
            if r
              return r

        null

    page = []

    for child in [].concat @props.children
      resource = matches(child.props.resource)
      if resource
        page.push child.handler.call(child, resource.parse(@state.path))
        if !@props.multiple
          break

    if page.length == 0
      page.push @props.error()

        
    dom.div null,
      page