Link = require "./Link"

makeFactory = (nodeFactory) ->
  (className) ->
    defineComponent
      render: ->
        @transferPropsTo nodeFactory
          className: className + " " + @props.className
          @props.children

div =   makeFactory dom.div
span =  makeFactory dom.span
li =    makeFactory dom.li
a =     makeFactory Link

button = (className) ->
  defineComponent
    render: ->
      @transferPropsTo dom.button
        type: "button"
        className: "btn #{className} #{@props.className}"
        @props.children


input = (type) ->
  defineComponent
    render: ->
      @transferPropsTo dom.input
        className: "form-control #{@props.className}"
        type: type
        @props.children


text = input "text"
textArea = defineComponent
  render: ->
    @transferPropsTo dom.textarea
      className: "form-control #{@props.className}"
      @props.children

inputGroup = (child) ->
  defineComponent
    render: ->
      addon = null
      if @props.addon
        addon = dom.span
          className: "input-group-addon"
          @props.addon

      dom.div
        className: "input-group"
        addon
        @transferPropsTo child()


formGroup = (child) ->
  defineComponent
    value: -> @refs.child.getDOMNode().value
    getDefaultProps: ->
      errors: {}
    hasErrors: ->
      @getErrors() && @getErrors().length > 0
    getErrors: ->
      @props.errors[@props.name]
    render: ->
      if @props.label
        label = dom.label
          htmlFor: @props.name
          @props.label

      if @hasErrors()
        errors = dom.div
          className: "has-errors"
          @getErrors().map (error) ->
            dom.span 
              className: "error"
              error

      dom.div
        className: "form-group"
        key: @props.name
        label
        errors
        @transferPropsTo child
          id: @props.name
          ref: "child"


select = defineComponent
  getInitialState: -> {}
  getValue: ->
    if !@state.value
      @props.defaultValue
    else
      @state.value

  setValue: (value) ->
    @setState
      value: value


  render: ->
    @transferPropsTo dom.select 
      className: "form-control"
      value: @getValue()
      onChange: ((e) ->
        @setValue(e.target.value)
        if @props.onChange
          @props.onChange(e)
      ).bind @

      @props.options


module.exports = 
  container:      div "container"
  containerFluid: div "container-fluid"

  row:        div "row"
  col:        defineComponent
    render: ->
      classes = []
      if @props.xs
        classes.push "col-xs-#{@props.xs}"
      if @props.sm
        classes.push "col-sm-#{@props.sm}"
      if @props.md
        classes.push "col-md-#{@props.md}"
      if @props.lg
        classes.push "col-lg-#{@props.lg}"


      @transferPropsTo dom.div
        className: classes.join(" ") + " " + @props.className
        @props.children

  glyph:      defineComponent
    render: ->
      dom.span
        className: "glyphicon glyphicon-#{@props.children} #{@props.className}"
          
  caret:      span "caret"
  caretUp:    defineComponent
    render: ->
      dom.span
        className: "dropup"
        dom.span
          className: "caret"

  divider:    li "divider"

  buttonToolbar:  div "btn-toolbar"

  button:         a "btn btn-default"
  buttonPrimary:  a "btn btn-primary"
  buttonDanger:   a "btn btn-danger"
  buttonSuccess:  a "btn btn-success"
  buttonInfo:     a "btn btn-info"
  buttonLink:     a "btn btn-link"

  formGroup:      formGroup
  textInput:      formGroup text
  textArea:       formGroup textArea
  passwordInput:  formGroup input "password"
  datePicker:     formGroup input "date"
  submit:         formGroup defineComponent
    render: ->
      @transferPropsTo dom.input
        type: "submit"
        className: "btn btn-primary"

  inlineSelect: select
  select: formGroup select
  hidden: input "hidden"


  table: defineComponent
    render: ->
      @transferPropsTo dom.table
        className: "table #{@props.className}"
        @props.children

  pagination: defineComponent
    setPage: (page) ->
      if page <= @props.pages && page >= 0
        @props.setPage(page)

    next: ->
      @setPage(@props.currentPage + 1)

    previous: ->
      @setPage(@props.currentPage - 1)

    render: ->
      previous = dom.li 
        onClick: @previous
        className: getReact().addons.classSet
          disabled: @props.currentPage <= 1
        dom.a null, "‹"

      next = dom.li 
        onClick: @next
        className: getReact().addons.classSet
          disabled: @props.currentPage >= @props.pages

        dom.a null, "›"
      @transferPropsTo dom.ul
        className: "pagination #{@props.className}"
        previous
        [1..Math.max(@props.pages, 1)].map ((n) ->
          cx = 
          classes = 
          dom.li
            className: getReact().addons.classSet
              active: n == @props.currentPage
            onClick: (-> @setPage n).bind @

            key: n
            dom.a null, n
        ).bind @
        next

  modal: defineComponent
    updateVisibility: ->
      if @isOpen()
        $(@getDOMNode()).modal("show")
      else
        $(@getDOMNode()).modal("hide")

    getInitialState: ->
      open: null

    getDefaultProps: ->
      open: false

    isOpen: ->
      @props.open && @state.open != false

    componentWillReceiveProps: (nextProps) ->
      @setState
        open: null


    render: ->
      footer = null
      if @props.footer
        footer = dom.div
          className: "modal-footer"
          @props.footer

      dom.div
        className: "modal fade"
        role: "dialog" 
        tabIndex: -1
        dom.div
          className: "modal-dialog"
          dom.div
            className: "modal-content"
            dom.div
              className: "modal-header"
              dom.button
                type: "button"
                className: "close"
                "data-dismiss": "modal"

                dom.span
                  "aria-hidden": true
                  "×"

                dom.span
                  className: "sr-only"
                  "Close"
              dom.h4 null, @props.title

            dom.div
              className: "modal-body"
              @props.children

            footer

    componentDidMount: ->
      @updateVisibility()
      $(@getDOMNode()).bind "hidden.bs.modal", (->
        @setState
          open: false
      ).bind @

    componentDidUpdate: ->
      @updateVisibility()


