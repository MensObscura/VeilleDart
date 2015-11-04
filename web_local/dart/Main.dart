import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'Rest.dart';
import 'Chat.dart';




void main() async {

	Chat chat = new Chat();

	Rest rest = new Rest(chat);

	rest.run();
	chat.run();

}

