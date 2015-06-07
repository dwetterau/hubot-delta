class Parser
  constructor: ->

  parseNameDateTime: (options) ->
    if options.search(/\s+on\s+/) >= 0
      [name, dateTime] = (x.trim() for x in options.split /\s+on\s+/)
    if dateTime?
      toTest = dateTime
    else
      toTest = options

    if options.search(/\s+at\s+/) >= 0
      [dateOrName, time] = (x.trim() for x in toTest.split /\s+at\s+/)

    if dateTime?
      if time?
        date = dateOrName
      else
        date = dateTime
        time = null
    else
      date = null
      if dateOrName?
        name = dateOrName
      else
        name = options

    return [name, date, time]

module.exports = Parser
