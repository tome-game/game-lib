do (root = global ? window) ->
  root.tome ?= {}
  root.tome.game = version: '$VERSION$'