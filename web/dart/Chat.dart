import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'Channel.dart';
import 'User.dart';

class Chat{


List<Channel> _channels;
Channel _global;
static int PORT = 9090;

Chat(){

		

}


List<Channel> get channels => _channels;
Channel get global => _global;

set global(Channel channel) => _global=channel;
set channels(List<Channel> channels) => _channels=channels;


void run(){
	

		HttpServer.bind('0.0.0.0', PORT, shared: true).then((HttpServer server) {

		    print('Server listening on port ${PORT}.');
		    
		    server.listen((HttpRequest request) {
		     if (WebSocketTransformer.isUpgradeRequest(request)) {
		       WebSocketTransformer.upgrade(request).then((WebSocket ws) {
		       	  String channel = request.uri.path.substring(1,request.uri.path.length);
		          this.add(ws,channel);
			
		          ws.listen((String message) {
		           	this.send("${message}",channel);
		          },
		          onDone: () {
		            this.remove(ws, channel);
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
	
	void send(message, name){
		
		int channel = getChannel(name);
		if( channel > -1){
		List<WebSocket> connections = _channels.elementAt(channel).connections;
		
		for (WebSocket connection in connections) {
	        connection.add(message);
	    }
	    }
	}
	
	
	
	void add(WebSocket con, String  name){

		 
		
		
		int channel = getChannel(name);
		
		if( channel > -1){
		_channels.elementAt(channel).connections.add(con);
		int index = _channels.elementAt(channel).connections.indexOf(con);
		
		if(index > -1){ 
		
		User user = _channels.elementAt(channel).users.elementAt(index);
		this.send("*** "+user.name+ " joined the channel " + name+" ***", name);
		}else{
		
		
		this.send("*** Can't join the channel " + name+" ***", name);
		}
		
		}
	}
	
	void remove(WebSocket con, String  name){
		
		
		int channel = getChannel(name);
		
		if( channel > -1){
		
		int index = _channels.elementAt(channel).connections.indexOf(con);
		
		if( index > -1 ){
		_channels.elementAt(channel).connections.removeAt(index);
		User user = _channels.elementAt(channel).users.elementAt(index);
		 _channels.elementAt(channel).removeUser(index);
		
		this.send("*** "+user.name+ " left the channel " + name+" ***", name);
		}else{
			this.send("*** Can't left the channel " + name+" ***", name);
		     }
		}
	}
	
	
	int getChannel(String name){
	int i =0;
for (Channel channel in channels){

if( channel.name == name){
print('find');
return i;
}
i++;
	}

print('nop ${name} ');
return -1;
	
	}
	
	}
