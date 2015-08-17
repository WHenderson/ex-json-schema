class SchemaError extends Error
  constructor: (message, context, info, innerErrors) ->
    base = super(message)

    @message = base.message
    @stack = base.stack
    @name = @constructor.name

    @context = context
    @info = info
    @innerErrors = innerErrors
