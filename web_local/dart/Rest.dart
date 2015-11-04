import 'dart:io';
import 'dart:core';
import 'dart:convert';

import 'Channel.dart';
import 'User.dart';

class Rest {


	Chat _chat;

	Rest(this._chat);

	Future run() async {

		var requestServer = await HttpServer.bind("0.0.0.0", 8080);

		print('listening on localhost, port ${requestServer.port}');

		await for (HttpRequest request in requestServer) {
			switch(request.method){
				case 'GET':
				handleGetRequest(request);
				break;
				case 'POST':
				handlePostRequest(request);
				break;
				default:
				handleDefaultRequest(request);
			}
		}

	}



	void handleGetRequest(HttpRequest request) async{
		try {
			Map jsonData = request.uri.queryParameters;

			if(jsonData['channel'] != null && jsonData['channel'] != ''){

				String jsonString = getUsers(jsonData['channel']);
				print(jsonString);


				HttpResponse res = request.response;
				addCorsHeaders(res);   
				res.write(jsonString);
				res.close();

			}else{

				String jsonString = getChannels();
				print(jsonString);


				HttpResponse res = request.response;
				addCorsHeaders(res);   
				res.write(jsonString);
				res.close();
			}
		}catch(e){
			print('Unknown exception: $e');
		}
	}

	void handlePostRequest(HttpRequest request) async{
		var jsonString = await request.transform(UTF8.decoder).join();
		Map jsonData = JSON.decode(jsonString);

		if(jsonData['pseudo'] != null && jsonData['pseudo'] != ''){

			if(_chat.global == null && jsonData['channel'] == 'Hall' ){
				_chat.global = await new Channel('Hall');

				if(_chat.channels == null){
					_chat.channels = await new List<Channels>();
				}

				_chat.channels.add(_chat.global);
			}
			_chat.global.addUser(new User(jsonData['pseudo']));
			HttpResponse res = request.response;
			addCorsHeaders(res);   
			res.close();
		}


		if(jsonData['nom'] != null && jsonData['nom'] != ''){

			print(jsonString);

			if(jsonData['action'] == 'add'){ 
				addChannel(jsonData['nom'],jsonData['channel'],jsonData['user']);
			}

			if(jsonData['action'] == 'join'){
				
				joinChannel(jsonData['nom'],jsonData['channel'],jsonData['user']);

			}

		}
	}


	void addChannel(String dest, String current, String user) {


		_chat.channels.add(new Channel(dest));

	}


	void joinChannel(String dest, String current, String user) async {

		int index = findChannel(dest);
		if(index < 0){
			_chat.channels.add(new Channel(dest));
			joinChannel(dest,current,user);
		}else{
			await _chat.channels.elementAt(index).addUser(new User(user));
		}

	}


	int findChannel(String name){

		return _chat.getChannel(name);


	}

	void handleDefaultRequest(HttpRequest request){
		request.response
		..statusCode = HttpStatus.METHOD_NOT_ALLOWED
		..write('Unsupported request: ${request.method}.')
		..close();
	}

	void addCorsHeaders(HttpResponse res) {
		res.headers.add("Access-Control-Allow-Origin", "*");
		res.headers.add("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
		res.headers.add("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
	}


	String getChannels(){
		try{
			List<Channel> channels =_chat.channels;

			String list ='''{"channels":[''';

			if(channels != null){

				for(Channel channel in channels){
					list += '''"${channel.name}",''';
				}

			}

			list = list.substring(0,list.length-1);
			list+=''']}''';

			return list;

		} catch(e){
			print('Unknown exception: $e');
			return '''{"channels":["fail"]}''';
		}

	}





	String getUsers(String channel){
		try{
			int index = findChannel(channel);

			if(index > -1){
				Channel chan =_chat.channels.elementAt(index);

				String list ='''{"users":[''';

				if(chan != null && chan.users != null){

					for(User user in chan.users){
						list += '''"${user.name}",''';
					}

				}

				list = list.substring(0,list.length-1);
				list+=''']}''';

				return list;
			}else{

				return '''{"users":["Channel not found"]}''';
			}
		} catch(e){
			print('Unknown exception: $e');
			return '''{"user":["fail"]}''';
		}

	}
}
