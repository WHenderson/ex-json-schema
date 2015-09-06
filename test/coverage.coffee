assert = require('chai').assert

suite('coverage', () ->
  suite('internal', () ->
    require('./internal/ecma262.coffee')
    require('./internal/rfc4627.coffee')
    require('./internal/context.coffee')
    require('./internal/util.coffee')
    require('./internal/json-schema-core.coffee')
    require('./internal/json-schema-validation.coffee')
  )

  suite('normalize', () ->
    require('./normalize/5-1-numeric.coffee')
    require('./normalize/5-2-string.coffee')
    require('./normalize/5-3-array.coffee')
    require('./normalize/5-4-object.coffee')
    require('./normalize/5-5-any.coffee')
    require('./normalize/6-metadata.coffee')
    require('./normalize/7-format.coffee')
  )
)
