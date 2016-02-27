fs = require 'fs'
path = require 'path'

colors = require 'colors/safe'

setting = require './settings'
output = require './output'
output.setDest setting.dest
format = require './format'
format.init()

LEVELS = setting.LEVELS
COLORS = setting.COLORS
STATUS = setting.STATUS

#default open
_status = 1

_switch = (status)->
  if status
    _status = status
  else
    #if status not specified, switch it
    _status ^= 1

_logger = (level = 1, content)->
  if _status
    levelColor = COLORS[level]
    output.log format.f(content), levelColor

module.exports = 
  debug: (content)->
    _logger(LEVELS.DEBUG, content) if LEVELS[setting.level] >= LEVELS.DEBUG

  info: (content)->
    _logger(LEVELS.INFO, content) if LEVELS[setting.level] >= LEVELS.INFO

  error: (content)->
    _logger(LEVELS.ERROR, content)

  setOutput: (config)->
    output.setDest config

  setLevel: (level = "INFO")->
    if typeof level is 'number'
      setting.setLevelByNumber level
    else if typeof level is 'string'
      setting.setLevelByString level

  getLevel: ()->
    @debug setting.level
    return setting.level  

  close: ()->
    _switch(0)

  pause: ()->
    @close()

  open: ()->
    _switch(1)

