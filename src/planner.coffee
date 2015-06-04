EventManager = require './event_manager'
eventManager = null

Parser = require './parser'
parser = null

handleCreateEvent = (msg, options) ->
  [name, description] = parser.parseNameDescription options
  eventManager.createEvent msg, name, description

handleJoinEvent = (msg, options) ->


module.exports = (robot) ->
  eventManager = new EventManager(robot)
  parser = new Parser()

  robot.hear ///
    ^delta  # Required prefix
    \s+
    (\w+)   # The command
    \s+
    (.*)    # Other options to parse
    $       # End of line
  ///i, (msg) ->
    [_, command, options] = msg.match
    switch command
      when 'create' then handleCreateEvent(msg, options)
      else msg.send 'Unknown Delta command!'

