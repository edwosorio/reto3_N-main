import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/model/message.dart';
import '../controllers/authentication_controller.dart';
import '../controllers/chat_controller.dart';

// Widget con la interfaz del chat
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // controlador para el text input
  late TextEditingController _controller;
  // controlador para el sistema de scroll de la lista
  late ScrollController _scrollController;
  late String remoteUserUid;
  late String remoteEmail;

  // obtenemos los parámetros del sistema de navegación
  dynamic argumentData = Get.arguments;

  // obtenemos las instancias de los controladores
  ChatController chatController = Get.find();
  AuthenticationController authenticationController = Get.find();

  @override
  void initState() {
    super.initState();
    // obtenemos los datos del usuario con el cual se va a iniciar el chat de los argumentos
    remoteUserUid = argumentData[0];
    remoteEmail = argumentData[1];

    // instanciamos los controladores
    _controller = TextEditingController();
    _scrollController = ScrollController();

    // Le pedimos al chatController que se suscriba los chats entre los dos usuarios
    chatController.subscribeToUpdated(remoteUserUid);
  }

  @override
  void dispose() {
    // proceso de limpieza
    _controller.dispose();
    _scrollController.dispose();
    chatController.unsubscribe();
    super.dispose();
  }

  Widget _item(Message element, int posicion, String uid) {
    
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 10,
        shadowColor: Colors.white,
        margin: const EdgeInsets.all(4.0),
        // cambiamos el color dependiendo de quién mandó el usuario
        color:  Color.fromARGB(255, 65, 124, 106) ,
        child: ListTile(
          title: Text(
            element.msg,
            textAlign:
                // cambiamos el textAlign dependiendo de quién mandó el usuario
                uid == element.senderUid ? TextAlign.right : TextAlign.left,
            style: TextStyle(color: uid == element.senderUid ? Colors.white : Colors.yellowAccent),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    String uid = authenticationController.getUid();
    logInfo('Current user $uid');
    // Escuchamos la lista de mensajes entre los dos usuarios usando el ChatController
    return GetX<ChatController>(builder: (controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
      return ListView.builder(
        itemCount: chatController.messages.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          var element = chatController.messages[index];
          return _item(element, index, uid);
        },
      );
    });
  }

  Future<void> _sendMsg(String text) async {
    // enviamos un nuevo mensaje usando el ChatController
    logInfo("Calling _sendMsg with $text");
    await chatController.sendChat(remoteUserUid, text);
  }

  Widget _textInput() {
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 5.0, top: 5.0),
              child: TextField(
                autofocus: true,
                autocorrect: true,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                key: const Key('MsgTextField'),

                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.bolt, color: Colors.white,),
                  hintText: ' Nuevo mensaje...',
                  hintStyle: TextStyle(color: Colors.white38),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(color: Colors.white, width: 1,)
                  ),
                  labelText: 'Mensaje...',
                  labelStyle: TextStyle(
                    color: Colors.white
                  )
                ),
                onSubmitted: (value) {
                  _sendMsg(_controller.text);
                  _controller.clear();
                },
                controller: _controller,
              ),
            ),
          ),
          TextButton(
              key: const Key('sendButton'),
              child: const Text('Enviar', style: TextStyle(color: Colors.white),),
              onPressed: () {
                _sendMsg(_controller.text);
                _controller.clear();
              })
        ],
      ),
    );
  }

  _scrollToEnd() async {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToEnd());
    return Scaffold(
        backgroundColor: Colors.lightBlue[900],
        appBar: AppBar(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          shadowColor: Colors.white,
          backgroundColor: Colors.lightBlue[900],
          title: Text("Chat con  $remoteEmail")),
        
        body: Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 25.0),
          child: Column(
            
            children: [
              const Divider(),
              Expanded(
                flex: 4, 
                child: _list()), 
                _textInput()],
          ),
        ));
  }
}
