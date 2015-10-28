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
	
	
	User getUser(String name){

		for(User user in _users){
		
			if(user.name == name){
			
				return user;
			
			}
		
		}	
	
	
	}
	
		int getIndexUser(String name){
		int i =0;
		for(User user in _users){
		
			if(user.name == name){
			
				return i;
			
			}
			i++;
		
		}	
		return -1;
	
	}
	
	
	void addUser(User user){

		_users.add(user);
		user.channel=this._name;

		this.send("*** "+user.name+ " joined the channel " + _name+" ***");
		print ("*** "+user.name+ " joined the channel " + _name+" ***");
	
	}
	
	void add(WebSocket con){

		_connections.add(con);
	}
	
	
		
	void removeUser(String user){
		
		int index  = this.getIndexUser(user);
		
		if( index > -1 ){
		WebSocket con = this._connections.elementAt(index);
		this._users.removeAt(index);
		this._connections.removeAt(index);
		this.send("*** "+user+ " left the channel " + _name+" ***");
		print("*** "+user+ " left the channel " + _name+" ***");
		}
	}
	
	
	void remove(WebSocket con){
		
		int index  = this._connections.indexOf(con);
		
		if( index > -1 ){
		User user = this._users.elementAt(index);
		this._users.removeAt(index);
		this._connections.removeAt(index);
		this.send("*** "+user.name+ " left the channel " + _name+" ***");
		}
	
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


		          ws.listen((String message) {		       
		           	this.send(message);
		          },
		          onDone: () {
		            this.remove(ws);
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
