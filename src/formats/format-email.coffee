do ->
  re = /^\S+@\S+$/

  Formats::['is_email'] = (value) ->
    re.test(value)

  return
