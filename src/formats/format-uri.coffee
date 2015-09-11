do ->
  re = /^[a-zA-Z][a-zA-Z0-9+-.]*:[^\s]*$/

  Formats::['is_uri'] = (value) ->
    re.test(value)

  return


