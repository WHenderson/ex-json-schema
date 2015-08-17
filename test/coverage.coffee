assert = require('chai').assert

suite('coverage', () ->
  suite('internal', () ->
    require('./internal/context.coffee')
  )

  suite('normalize', () ->
    require('./normalize/5-1-numeric.coffee')
  )
)
