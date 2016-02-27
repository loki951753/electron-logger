path = require('path')

#Stack trace format :
#https://github.com/v8/v8/wiki/Stack%20Trace%20API
stackReg = /at\s+(.*)\s+\((.*):(\d*):(\d*)\)/i
stackReg2 = /at\s+()(.*):(\d*):(\d*)/i

class Format
  init: (config)->
    #you can extends codes here to set various format
    
  getTime: ()->
    time = new Date()
    return "#{time.getHours()}:#{time.getMinutes()}:#{time.getSeconds()}:#{time.getMilliseconds()}"

  getInfoStack: ()->
    s = (new Error()).stack.split('\n')[5]
    stackInfo = stackReg.exec(s) || stackReg2.exec(s)
    data = {}
    if stackInfo and (stackInfo.length is 5)
      data.method = stackInfo[1]
      data.path = stackInfo[2]
      data.line = stackInfo[3]
      data.pos = stackInfo[4]
      data.file = path.basename data.path
    return "#{data.file}:#{data.line}"

  f: (content)->
    contentType = typeof content
    
    switch contentType
      when "string"
        str = content
      when "function"
        str = content.toString()
      when "object"
        str = JSON.stringify content
      when "undefined"
        str = "undefined"
      else
        str = content

    return "#{@getTime()} [#{@getInfoStack()}]>>#{str}"
module.exports = new Format()
