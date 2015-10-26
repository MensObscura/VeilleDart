import 'dart:html';
import 'package:firebase/firebase.dart' show Firebase;


void main(){
	// InputElement nameField = querySelector("#name-input");
	// InputElement messageField = querySelector("#message-input");

	var fbLogin = new Firebase("https://chat-veille-techno.firebaseio.com/Users/Login");

  fbLogin.onValue.listen((event) {
    List users = event.snapshot.val();
        print(users);
  });

  // print(fbLogin.onChildAdded);

  // fbLogin.((FB.Event event){
  // 	Map data = event.snapshot.val();

  // 	print(data);
  // });

	print("Hello, World");
}