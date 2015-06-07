assert = require 'assert'

Parser = require('../parser')
parser = null

describe 'parser', ->
  before ->
    parser = new Parser()

  describe 'name and description parsing', ->
    it 'should just return a name when there is no date or time', ->
      name = 'Just a name'
      result = parser.parseNameDateTime name
      assert.equal result.length, 3
      assert.equal result[0], name
      assert.equal result[1], null
      assert.equal result[2], null

    it 'should return the name and description when both are present', ->
      name = 'Just a name'
      date = 'the date'
      result = parser.parseNameDateTime(name + ' on ' + date)
      assert.equal result.length, 3
      assert.equal result[0], name
      assert.equal result[1], date
      assert.equal result[2], null
