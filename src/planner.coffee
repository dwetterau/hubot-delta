EventManager = require './event_manager'
eventManager = null

handleCreateEvent = (msg, options) ->
  if options.indexOf '-' >= 0
    [name, description] = (x.trim() for x in options.split '-')
  else
    name = options
  eventManager.createEvent msg, name, description

handleJoinEvent = (msg, options) ->


module.exports = (robot) ->
  eventManager = new EventManager(robot)

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

