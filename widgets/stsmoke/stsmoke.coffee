class Dashing.Stsmoke extends Dashing.Widget
  constructor: ->
    super
    @queryState()

  @accessor 'state',
    get: -> @_state ? "Unknown"
    set: (key, value) -> @_state = value

  @accessor 'icon',
    get: -> @['icon'] ? 'fire'
    set: Batman.Property.defaultAccessor.set

  updateBackgroundColor: ->
    if @get('state') == 'clear'
      $(@node).css 'background-color', '#888888'
    else
      $(@node).css 'background-color', '#dc9145'

  queryState: ->
    $.get '/smartthings/dispatch',
      widgetId: @get('id'),
      deviceType: 'smoke',
      deviceId: @get('device')
      (data) =>
        json = JSON.parse data
        @set 'state', json.state
        @updateBackgroundColor()

  ready: ->

  onData: (data) ->
    @updateBackgroundColor()
