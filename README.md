# electron-logger
a simple tool to help my electron develop work and keep user client running log.

electron-logger is a simple tool, while still can satisfy my electron develop work. Any PR(format, writstream, etc..) will be appreciated.

#usage
```javascript
var logger = require('electron-logger');

//output format:
//{{timestamp}} [{{filename}}:{{lineNumber}}]>> {{log_content}}
//16:46:55:111 [test.js:4]>>a info message
logger.info("a info message");


logger.setLevel("info");
logger.setLevel(1);

logger.getLevel();//"info"

logger.close();
logger.pause();
logger.open();

logger.setOutput({file:"./tmp.log"});
```

#practice
I set the output to be `{terminal:false;file:%APPDATA%}` by default in production. Add a hot-key in the render process, when user encounts some bug, fire the hot-key and open the `%APPDATA%` directory then send the log to customer service(you can also add a backend port to send the message to the server).
