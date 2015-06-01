fs = require 'fs'
path = require 'path'

module.exports = (robot, scripts) ->
  scriptsDirectory = path.resolve(__dirname, 'src')
  fs.exists scriptsDirectory, (doesExist) ->
    if doesExist
      for script in fs.readdirSync scriptsDirectory
        if scripts? and "*" not in scripts
          robot.loadFile(scriptsDirectory, script) if script in scripts
        else
          robot.loadFile scriptsDirectory, script
