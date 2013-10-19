uuid = require 'node-uuid'

class tome.Entity

  @id = -> uuid.v4()

  constructor: (components=[]) ->
    @components = {}
    @add(component) for component in components

  add: (component) ->
    @components[component.name] = component

  id: ->
    @components.id ||= Entity.id()