assert = require('chai').assert

suite('5.4 object', () ->
  require('./5-4-1-maxProperties.coffee')
  require('./5-4-2-minProperties.coffee')
  require('./5-4-3-required.coffee')
  require('./5-4-4-additionalProperties-properties-patternProperties.coffee')
  require('./5-4-5-dependencies.coffee')
)
