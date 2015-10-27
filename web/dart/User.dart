import 'dart:core';
class User {

String _name;

String _channel;


User(this.name);

	String get name => _name;

	String get channel => _channel;

	String set channel(String channel) => _channel;

}
