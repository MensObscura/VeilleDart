import 'dart:html';
import 'dart:convert' show UTF8, JSON;

  ButtonElement add = querySelector('#add');
  DivElement divChannel =  querySelector('#divchannels');
  ButtonElement join = querySelector('#join');
  DivElement adding = querySelector('#adding');
  InputElement name;
  Storage localStorage = window.localStorage;
  String nickname =localStorage['username'];
    String channel =localStorage['channel'];
    String selected ;
void main() {



   

	getChannels();
 
      		 
      		 
      		 
  join.onClick.listen((MouseEvent event) {
  	 
  	 joinChannel();
	
	
  });
  
    add.onClick.listen((MouseEvent event) {
  	 add.disabled=true;
  	   adding.innerHtml="";
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

if(selected != null && selected != ''){
var url = 'http://172.28.1.153:8080';
    var data = {'nom':'${selected}','user':'${nickname}','channel':'${channel}','action':'join'};
  
    var request = new HttpRequest()..open('POST', url)
    				               ..send(JSON.encode(data));
localStorage['channel'] = '${selected}';
window.location.assign('chat.html');
}else{
adding.innerHtml="<p>Veuillez choisir un channel</p>";
}
}



addChannel(){


var url = 'http://172.28.1.153:8080';
var nameChannel = name.value;
 nameChannel = nameChannel.replaceAll(" ","_");
    var data = {'nom':'${nameChannel}','user':'${nickname}','channel':'${channel}','action':'add'};
  
    var request = new HttpRequest()..open('POST', url)
    				               ..send(JSON.encode(data));
	
}





getChannels(){




  requestComplete(HttpRequest request) {
    divChannel.innerHtml='';
    if (request.status == 200) {
      
             
      var jsonString = request.responseText;
  	 Map jsonData = JSON.decode(jsonString);
      List<String> channelList = jsonData['channels'];
      for (int i = 0; i < channelList.length; i++) {
        divChannel.innerHtml+= "<input type='radio' name='channel' value='${channelList[i]}'>${channelList[i]}</br>";
      }
    } else {
 
      divChannel.innerHtml+= "<input type='radio' name='channel' value='fail'>Request failed, status=${request.status}";
    }
    
    	queryAll('[name="channel"]').forEach((InputElement radioButton) {
    radioButton.on['click'].listen((e) {
      InputElement clicked = e.target;
      print("The channel is ${clicked.value}");
      selected =clicked.value;
    });
  });

  }
  
 var url = 'http://172.28.1.153:8080';
    print(url);
    var request = new HttpRequest();
    request..open('GET', url)
     		   ..onLoadEnd.listen((e) => requestComplete(request))
      		 ..send('');
      		 
     }
