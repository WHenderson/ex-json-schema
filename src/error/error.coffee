class SchemaError extends Error
  constructor: (message, info) ->
    base = super(message)

    @message = base.message
    @stack = base.stack
    @name = @constructor.name

    @info = info
