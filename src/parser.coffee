class Parser
  constructor: ->

  parseNameDescription: (options) ->
    if options.indexOf('on') >= 0
      [name, dateTime] = (x.trim() for x in options.split 'on')
    if dateTime?
      toTest = dateTime
    else
      toTest = options

    if options.indexOf('at') >= 0
      [dateOrName, time] = (x.trim() for x in toTest.split 'at')

    if dateTime?
      if time?
        date = dateOrName
      else
        time = null
    else
      if dateOrName?
        name = dateOrName
      else
        name = options

    return [name, date, time]

module.exports = Parser
