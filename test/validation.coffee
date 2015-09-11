assert = require('chai').assert
fs = require('fs')
path = require('path')

testFilePaths = [
  'additionalItems.json'
  'additionalProperties.json'
  'allOf.json'
  'anyOf.json'
  'default.json'
  #'definitions.json'
  'dependencies.json'
  'enum.json'
  'items.json'
  'maximum.json'
  'maxItems.json'
  'maxLength.json'
  'maxProperties.json'
  'minimum.json'
  'minItems.json'
  'minLength.json'
  'minProperties.json'
  'multipleOf.json'
  'not.json'
  'oneOf.json'
  'pattern.json'
  'patternProperties.json'
  'properties.json'
  #'ref.json'
  #'refRemote.json'
  'required.json'
  'type.json'
  'uniqueItems.json'
  #'optional/bignum.json'
  #'optional/format.json'
  #'optional/zeroTerminatedFloats.json'
]

mapErrors = (errors) ->
  return errors.map((error) ->
    info = error.info
    if info.cContext? and info.cContext.pathString?
      info.cContext = info.cContext.pathString()

    result = {
      message: error.message
      info: error.info
      path: error.context.pathString()
    }
    if error.innerErrors? and error.innerErrors.length != 0
      result.innerErrors = mapErrors(error.innerErrors)
    return result
  )

suite('validation', () ->
  exJsonSchema = null
  engine = null
  setup(() ->
    exJsonSchema = require('../dist/ex-json-schema.coffee')
    engine = new exJsonSchema()
  )

  for testFilePath in testFilePaths
    do (testFilePath) ->
      jsonSuites = JSON.parse(fs.readFileSync(path.join(__dirname, '../test-suite/tests/draft4', testFilePath)))

      suite(testFilePath, () ->
        for jsonSuite in jsonSuites
          do (jsonSuite) ->
            suite(jsonSuite.description, () ->
              validator = null
              setup(() ->
                validator = engine.compile(jsonSuite.schema)
              )

              for jsonTest in jsonSuite.tests
                do (jsonTest) ->
                  test(jsonTest.description, () ->
                    context = validator(jsonTest.data)

                    mappedErrors = mapErrors(context.errors)
                    expectedErrors = jsonTest.errors ? []

                    if not jsonTest.valid
                      jsonTest.errors = mappedErrors

                    assert.deepEqual(
                      mappedErrors,
                      expectedErrors,
                      'incorrect message output'
                    )
                    assert.deepEqual(context.success(), jsonTest.valid, 'incorrect validity')
                  )
            )

        teardown(() ->
          fs.writeFileSync(path.join(__dirname, '../test-results/tests/draft4', testFilePath), JSON.stringify(jsonSuites, null, '    '))
        )

      )
)
