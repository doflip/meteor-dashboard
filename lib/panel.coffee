root = exports ? this

class root.Panel
  constructor: (@options) ->

    # Initialization
    @_setCssClass()
    @_update()

    # Start Update Interval
    Meteor.setInterval @_update, @options.updateInterval

    $(window).on 'resize', @_updateSize
    $(window).trigger 'resize'

  _updateSize: (evt) =>
    ww = $(window).width()
    wh = $(window).height()
    gridUnitX = ww / Session.get('grid_units_x')
    gridUnitY = wh / Session.get('grid_units_y')

    # Calculate Size
    width = @options.gridSizeX * gridUnitX
    height = @options.gridSizeY * gridUnitY

    #Apply Size and Position
    update Panels, @options._id,
      'width': width
      'height': height

  _setCssClass: ->
    update Panels, @options._id,
      'css_class': @options.panelCssClass

  _update: ->
    # This will implemented by panels that extend this class