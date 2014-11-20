_$ = null

Service = defineService "JQueryService", (services) ->
  $: -> _$

poll = ->
  if typeof $ != "undefined"
    _$ = $
    Service.update()
  else
    setTimeout(poll, 1000)

poll()
