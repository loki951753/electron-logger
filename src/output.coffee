fs = require 'fs'
path = require 'path'
stream = require('stream')

colors = require 'colors'
merge = require 'merge'

Readable = stream.Readable
Writable = stream.Writable

class Output
  setDest: (config)->
    if @config is undefined then @config = config else merge(@config, config)

    @rs ||= new Readable
      objectMode: true
    @rs._read = ()->

    # @ws stores the file writeStream for extension
    @ws ||= []
    files = @config.file
    if files
      if typeof files is "string"
        ws = fs.createWriteStream path.resolve(files), {flags:'a', encoding: "utf8"}
        @rs.pipe ws
        @ws.push ws
      else if typeof files is "array"
        files.forEach (ele, index, array)->
          ws = fs.createWriteStream path.resolve(ele), {flags:'a', encoding: "utf8"}
          @rs.pipe ws
          @ws.push ws

  #maybe we can also create a writable stream to pipe from @rs to write
  #to terminal with #different colors#
  #i tried with closure but failed
  #if you find a way, add the codes in setDest function(maybe you can have a try with transform stream)
  _outputToTerminal: (content, color)->
    if @config.terminal is true
      if color
        process.stdout.write colors[color](content)
      else
        process.stdout.write content
      process.stdout.write '\n\r'

  _outputToTerminaln: (content, color)->
    if @config.terminal is true
      if color
        process.stdout.write colors[color](content)
      else
        process.stdout.write content

  #add newline as default
  log: (content, color)->
    @_outputToTerminal content, color
    @rs.push content
    @rs.push '\n\r'

  logn: (content, @color)->
    @_outputToTerminaln content, color
    @rs.push content

module.exports = new Output()