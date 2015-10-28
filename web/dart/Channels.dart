import 'dart:html';
import 'dart:convert' show UTF8, JSON;

  ButtonElement add = querySelector('#add');
  UListElement ulChannel =  querySelector('#ulchannels');
  ButtonElement join = querySelector('#join');
  DivElement adding = querySelector('#adding');
  InputElement name;
void main() {



  
  
  
 

	getChannels();
 
      		 
      		 
      		 
  join.onClick.listen((MouseEvent event) {
  	 
  	 joinChannel();
	
	
  });
  
    add.onClick.listen((MouseEvent event) {
  	 add.disabled=true;
  	 
      adding.innerHtml="<label>Nom:</label><input type='login' class='form-control' id='nom'><button class='btn btn-default' id='send' >Add Channel</button>";
	
	ButtonElement send = querySelector('#send');
	name = querySelector('#nom');
	send.onClick.listen((MouseEvent event) {
		addChannel();
		getChannels();
		 add.disabled=false;
  	 
      adding.innerHtml="";
	});
	
	
  });
  

}

joinChannel(){
window.alert("join");
window.close();
}



addChannel(){


var url = 'http://localhost:8080';
    var data = {'nom':'${name.value}'};
    var request = new HttpRequest()..open('POST', url)
    				               ..send(JSON.encode(data));

}


getChannels(){

  requestComplete(HttpRequest request) {
    ulChannel.innerHtml='';
    if (request.status == 200) {
      
             
      var jsonString = request.responseText;
  	 Map jsonData = JSON.decode(jsonString);
      List<String> channelList = jsonData['channels'];
      for (int i = 0; i < channelList.length; i++) {
        ulChannel.children.add(new LIElement()..text = channelList[i]);
      }
    } else {
 
      ulChannel.children.add(new LIElement()..text = 'Request failed, status=${request.status}');
    }
  }
  
 var url = 'http://localhost:8080';
    print(url);
    var request = new HttpRequest();
    request..open('GET', url)
     		   ..onLoadEnd.listen((e) => requestComplete(request))
      		 ..send('');
      		 
     }
