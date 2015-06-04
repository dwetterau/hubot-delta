assert = require 'assert'

Parser = require('../parser')
parser = null

describe 'parser', ->
  before ->
    parser = new Parser()

  describe 'name and description parsing', ->
    it 'should just return a name when there is no -', ->
      name = 'Just a name'
      result = parser.parseNameDescription name
      assert.equal result.length, 2
      assert.equal result[0], name
      assert.equal result[1], null

    it 'should return the name and description when both are present', ->
      name = 'Just a name'
      description = 'The description'
      result = parser.parseNameDescription(name + ' - ' + description)
      assert.equal result.length, 2
      assert.equal result[0], name
      assert.equal result[1], description
