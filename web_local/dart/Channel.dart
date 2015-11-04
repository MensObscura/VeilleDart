import 'dart:core';
import 'dart:io';
import 'dart:core';
import 'User.dart';


class Channel {

	String _name;
	List<User> _users;
	List<WebSocket> _connections;


	Channel(this._name) {
		_users = new List<User>();
		_connections = new List<WebSocket>();

	}


	String get name => _name;
	List<WebSocket> get connections => _connections;
	List<User> get users => _users;




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


		print ("*** "+user.name+ " joined the channel " + _name+" ***");

	}




	User removeUser(String user){

		int index  = this.getIndexUser(user);

		if( index > -1 ){
			this._users.removeAt(index);

			print("*** "+user+ " left the channel " + _name+" ***");
		}
	}




}







