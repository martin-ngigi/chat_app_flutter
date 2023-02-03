import 'package:chat_app_flutter/pages/group_info.dart';
import 'package:chat_app_flutter/pages/services/database_service.dart';
import 'package:chat_app_flutter/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//stful
class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;

  const ChatPage({Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
    })
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
String admin = "";
Stream<QuerySnapshot>? chats;
TextEditingController messageController = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
  getChatAndAdmin();
    super.initState();
  }

getChatAndAdmin(){
  DatabaseService().getChats(widget.groupId).then((val){
    setState(() {
      chats = val;
    });
  });

  DatabaseService().getGroupAdmin(widget.groupId).then((val){
    setState(() {
      admin = val;
    });
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       centerTitle: true,
       elevation: 0,
       title: Text(widget.groupName),
       backgroundColor: Theme.of(context).primaryColor,
       actions: [
         IconButton(
             onPressed: (){
               nextScreen(context, GroupInfo(
                 groupId: widget.groupId,
                 groupName: widget.groupName,
                 adminName: admin,
                 ));
             },
             icon: Icon(Icons.info),),
       ],
     ),
      body: Stack(
        children: [
          //chat messages here
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter message to send...",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().microsecondsSinceEpoch,
      };

      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        messageController.clear();
      });

    }
    else{
      showSnackBar(context, Colors.red, "Cant Send an empty message");
    }
  }
}
