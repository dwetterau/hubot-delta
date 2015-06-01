# Description:
#   Helper class responsible for storing the event mappings and
#   communicating with the service
#
# Dependencies:
#   request
#
# Configuration:
#
# Commands:
#
# Author:
#   dwetterau
request = require 'request'

class EventManager
  constructor: (@robot) ->
    @deltaApiUrl = process.env.DELTA_API_URL
    return @robot.logger.error "No delta api url provided" unless @deltaApiUrl

    storageLoaded = =>
      @storage = @robot.brain.data.delta ||= {
        events: {}
        lastEventName: null
      }
      @robot.logger.debug "Delta Event Data Loaded. " + JSON.stringify(@storage, null, 2)

    @robot.on 'loaded', storageLoaded
    storageLoaded()

  error: (msg, error) ->
    @robot.logger.debug "There was an error. " + error
    if typeof error == 'object'
      message = "Oops!"
      for e in error
        if e.msg?
          message += ' ' + e.msg
        else if e.message?
          message += ' ' + e.message
        else
          message += ' ' + e
      msg.send message
    else
      msg.send "Oops! " + error

  createEvent: (msg, eventName, description, date) ->
    # Make the request to create the event
    # TODO: Make the request to join the user to the event
    # Reply about the user creating and joining the event
    # Set the last event name after it has been created successfully
    if not eventName?
      return @error msg, "You didn't specify an event name!"
    url = @deltaApiUrl + '/event/create'
    form = {
      name: eventName
      description
      date
    }
    request {url, method: 'POST', form}, (error, response, body) =>
      if error
        return @error msg, "Unable to create event at this time"
      body = JSON.parse(body)
      if not body.ok
        return @error msg, body.error

      body = body.body
      @storage.events[eventName] = body
      @storage.lastEventName = eventName
      @save()
      # TODO: Send back a link to the event on delta
      msg.send 'Created new event: ' + eventName + ' (' + body.shortId + ')'

  updateEvent: (msg, changedKey, changedValue, eventName) ->
    if not eventName?
      if @storage.lastEventName
        eventName = @storage.lastEventName
      else
        return @error msg, "You didn't specify an event name!"
    # Make the proper update to the event and reply if successfully completed

  save: ->
    @robot.logger.debug "Saving event data."
    @robot.brain.save()

module.exports = EventManager
