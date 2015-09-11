do ->
  re = /^\d{4}-(?:0[0-9]|1[0-2])-[0-9]{2}[tT ]\d{2}:\d{2}:\d{2}(\.\d+)?([zZ]|[+-]\d{2}:\d{2})$/

  Formats::['is_date-time'] = (value) ->
    re.test(value)

  return

