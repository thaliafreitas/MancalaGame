var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var players = [];

http.listen(3000, function(){
    console.log('Listening on *:3000');
});

io.on('connection', function(clientSocket) {

    console.log('a player connected');

    clientSocket.on('disconnect', function() {

        console.log('player disconnected');

        var nickname;
        for (var i=0; i<players.length; i++) {
          if (players[i]["id"] == clientSocket.id) {
            players[i]["isConnected"] = false;
            nickname = players[i]["nickname"];
            break;
          }
        }

        io.emit("players", players);
        io.emit("userExitUpdate", nickname);

    });


  clientSocket.on("exit", function(clientNickname){
    for (var i=0; i<players.length; i++) {
      if (players[i]["id"] == clientSocket.id) {
        players.splice(i, 1);
        break;
      }
    }

    for (var i=0; i<players.length; i++) {
        players[i]["number"] = i;
    }

    io.emit("players", players);
    io.emit("userExitUpdate", clientNickname);
  });


  clientSocket.on('chatMessage', function(clientNickname, message){
    var currentDateTime = new Date().toLocaleString();
    io.emit('newChatMessage', clientNickname, message, currentDateTime);
  });

  clientSocket.on('restart', function(restart){
    io.emit('restart', restart);
  });

  clientSocket.on('quit', function(nickname){
    io.emit('quit', nickname);
  });

  clientSocket.on('end', function(number){
    io.emit('winner', number);
  });

  clientSocket.on('gameMovement', function(movement){
    var currentDateTime = new Date().toLocaleString();
    io.emit('newGameMovement', movement, currentDateTime);
  });


  clientSocket.on("connect", function(clientNickname) {
      var message = "User " + clientNickname + " was connected.";
      console.log(message);

      var userInfo = {};
      var foundUser = false;
      for (var i=0; i<players.length; i++) {
        if (players[i]["nickname"] == clientNickname) {
          players[i]["isConnected"] = true;
          players[i]["id"] = clientSocket.id;
          userInfo = players[i];
          foundUser = true;
          break;
        }
      }

      if (!foundUser) {
        userInfo["number"] = players.length;
        userInfo["id"] = clientSocket.id;
        userInfo["nickname"] = clientNickname;
        userInfo["isConnected"] = true
        players.push(userInfo);
      }

      io.emit("players", players);
      io.emit("userConnectUpdate", userInfo)
  });

});
