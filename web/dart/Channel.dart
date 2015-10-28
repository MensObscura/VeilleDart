import 'dart:core';
import 'dart:io';
import 'dart:core';
import 'User.dart';


class Channel {

	String _name;
	static int PORT = 9090;
	List<User> _users;

	List<WebSocket> _connections;

	Channel(this._name) {

		_users = new List<User>();
		_connections = new List<WebSocket>();
		
		run();
	}


	String get name => _name;

	List<User> get users => _users;
	
	List<WebSocket> get connections => _connections;
	
	void addUser(User user){

		_users.add(user);
		user.channel=this._name;

		this.send("*** "+user.name+ " joined the channel " + _name+" ***");
		print ('adding');
	
	}
	
	void add(WebSocket con){

		_connections.add(con);
	}
	
	void remove(WebSocket con){
		
		int index  = this._connections.indexOf(con);
		User user = this._users.elementAt(index);
		this._users.remove(user);
		this._connections.remove(con);
		this.send("*** "+user.name+ " left the channel " + _name+" ***");
	
	}
	
	void send(message){
	
		for (WebSocket connection in _connections) {
	        connection.add(message);
	    }
	}
	
	void run(){
	
		HttpServer.bind("0.0.0.0", PORT, shared: true).then((HttpServer server) {
		    print('Server listening on port ${PORT}.');
		    
		    server.listen((HttpRequest request) {
		     if (WebSocketTransformer.isUpgradeRequest(request)) {
		       WebSocketTransformer.upgrade(request).then((WebSocket ws) {
		          this.add(ws);

		          print('Client connected, there are now ${_connections.length} client(s) connected.');

		          ws.listen((String message) {		       
		           	this.send(message);
		          },
		          onDone: () {
		            this.remove(ws);
		            print('Client disconnected, there are now ${_connections.length} client(s) connected.');
		          });
		        });
		      } else {
		        request.response.statusCode = HttpStatus.FORBIDDEN;
		        request.response.reasonPhrase = 'Websocket connections only!';
		        request.response.close();
		      }
		    });
		});
	
	}
	
	


}
