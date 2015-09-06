assert = require('chai').assert

suite('5.5 any', () ->
  require('./5-5-1-enum.coffee')
  require('./5-5-2-type.coffee')
  require('./5-5-3-allOf.coffee')
  require('./5-5-4-anyOf.coffee')
  require('./5-5-5-oneOf.coffee')
  require('./5-5-6-not.coffee')
  require('./5-5-7-definitions.coffee')
)
