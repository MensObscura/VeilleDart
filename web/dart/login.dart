import 'dart:html';
import 'package:firebase/firebase.dart' show Firebase;


void main(){
	// InputElement nameField = querySelector("#name-input");
	// InputElement messageField = querySelector("#message-input");

	var fbLogin = new Firebase("https://chat-veille-techno.firebaseio.com/Users/Login");
  print("toto");
  // print(fbLogin.onChildAdded);

  // fbLogin.((FB.Event event){
  // 	Map data = event.snapshot.val();

  // 	print(data);
  // });

	print("Hello, World");
}