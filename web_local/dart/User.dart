import 'dart:core';

class User {

	String _name;

	String _channel;


	User(this._name);

	String get name => _name;

	String get channel => _channel;

	set channel(String channel) => _channel=channel;

}
