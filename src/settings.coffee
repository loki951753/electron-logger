ENV = 
  dev: "development"
  pro: "production"

#same as colors.js
colorsArray =
  BLACK: "black"
  RED: "red"
  GREEN: "green"
  YELLOW: "yellow"
  BLUE: "blue"
  MAGENTA: "magenta"
  CYAN: "cyan"
  WHITE: "white"
  GRAY: "gray"
  GREY: "grey"


module.exports = 
  LEVELS :
    ERROR: 0
    INFO: 1
    DEBUG: 2

  COLORS : [colorsArray.RED, colorsArray.GREEN, colorsArray.BLUE]

  #logger status
  #0:closed
  #1:open
  STATUS : ["closed", "open"]

  environment: ENV.dev

  dest:
    terminal: true
    #string or array
    file: false

  level: "INFO"

  setLevelByString: (levelStr)->
    @level = levelStr.toUpperCase()

  setLevelByNumber: (levelNum)->
    for k,v of @LEVELS
      if v is levelNum
        @setLevelByString k
        return
