class Parser
  constructor: ->

  parseNameDescription: (options) ->
    if options.indexOf('-') >= 0
      [name, description] = (x.trim() for x in options.split '-')
    else
      name = options
      description = null
    return [name, description]

module.exports = Parser
