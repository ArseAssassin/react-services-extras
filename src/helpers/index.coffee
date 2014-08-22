module.exports =
  withProps: (component, props) ->
    (additionalProps) ->
      o = {}

      for k, v of additionalProps
        o[k] = v
      for k, v of props
        o[k] = v

      component o

  withErrors: (component, props) ->
    (errors) ->
      module.exports.withProps(component, props)
        errors: errors
