import 'dart:convert';
import 'dart:developer';
import 'package:doctoworld_doctor/Model/fetch_chat_model.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_doctor/repositories/send_message_repo.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/fetch_chat_repo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

class ChatScreen extends StatefulWidget {
  final Appointments? appointment;
  ChatScreen({this.appointment});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
TextEditingController sendMessageController = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState() {
    super.initState();
    getMethod(
        context,
        getNotifyTokenService,
        {
          'user_id': widget.appointment!.customerId,
          'role':'doctor'
        },
        false,
        getNotifyTokenRepo
    );
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      sendMessageController.clear();
      Get.find<LoaderController>().updateDataController(true);
    });
  }
  bool showSender = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.appointment!.name!,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 16,color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              padding: EdgeInsets.only(top: 0.0, bottom: 61),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/chatbg.png'),
                      fit: BoxFit.cover)),
              child: FadedScaleAnimation(
                MessageStream(appointment: widget.appointment,),
                durationInMilliseconds: 400,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,

              child: TextFormField(
                controller: sendMessageController,
                onChanged: (value){
                  if(value.isNotEmpty){
                    setState(() {
                      showSender = true;
                    });
                  }else{
                    setState(() {
                      showSender = false;
                    });
                  }
                },
                decoration: InputDecoration(
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    filled: true,
                    hintText: locale.writeYourMsg,
                    suffixIcon: !showSender
                        ?SizedBox()
                        :InkWell(
                      onTap: (){
                        postMethod(
                            context,
                            sendMessageService,
                            {
                              'message': sendMessageController.text,
                              'reciever_id': widget.appointment!.customerId,
                              'sender_id': storageBox!.read('doctor_id'),
                              'type': 'doctor'
                            },
                            true,
                            sendMessageRepo
                        );
                        scrollController
                            .animateTo(
                          scrollController
                              .position
                              .maxScrollExtent,
                          curve: Curves.easeOut,
                          duration:
                          const Duration(
                              milliseconds:
                              500),
                        );
                      },
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
final scrollController = ScrollController();

class MessageStream extends StatefulWidget {
  final Appointments? appointment;
  MessageStream({this.appointment});
  @override
  _MessageStreamState createState() => _MessageStreamState();
}

class _MessageStreamState extends State<MessageStream> {
  PusherClient? pusher;
  Channel? channel;
  String bk='ui';
  @override
  void initState() {
    // TODO: implement initState
    pusher = new PusherClient(
      "4c5093fc019ed2f139df",
      PusherOptions(
host: '',
        cluster: 'ap2',
        // if local on android use 10.0.2.2
      ),
    );



    pusher!.onConnectionStateChange((state) {
      log("previousState: ${state!.previousState}, currentState: ${state.currentState}");
    });
    pusher!.onConnectionError((error) {
      log("error: ${error!.message}");
    });

    channel = pusher!.subscribe("chat");

    channel!.bind(r'App\Events\MessageSent', (event) {
      setState(() {
        bk = event!.data.toString();
        scrollController
            .animateTo(
          scrollController
              .position
              .maxScrollExtent,
          curve: Curves.easeOut,
          duration:
          const Duration(
              milliseconds:
              500),
        );
      });
      log( 'newww-->> ${bk}');
      log( 'newww-1-->> ${jsonDecode(bk)}');
      Map<String, dynamic> tempMap = jsonDecode(bk);
      log( 'newww0-->> ${event!.data}');
      ChatData tempChatData = ChatData.fromJson(tempMap['message']);
      log('mewww1--->>${tempChatData.message}');
      Get.find<LoaderController>().updateMessageList(tempChatData);

    });
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(context, fetchChatService, {'type':'doctor','reciever_id':widget.appointment!.customerId,
      'sender_id':storageBox!.read('doctor_id'),}, true, fetchChatRepo);
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(_)=>_.dataLoader
          ?Center(child: CircularProgressIndicator(),)
          : ListView(
        controller: scrollController,

        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: List.generate(_.messageList.length, (index) => MessageBubble(
          sender: _.messageList[index].senderName,
          text: _.messageList[index].message,
          time: DateFormat('hh:mm a').format(DateTime.parse(_.messageList[index].createdAt!)),
          isDelivered: false,
          isMe: storageBox!.read('doctor_id').toString() == _.messageList[index].senderId.toString()
              ?true
              :false,
        ),),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool? isMe;
  final String? text;
  final String? sender;
  final String? time;
  final bool? isDelivered;

  MessageBubble(
      {this.sender, this.text, this.time, this.isMe, this.isDelivered});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 4.0,
            color: isMe!
                ? Theme.of(context).primaryColor
                : Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(6.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    text!,
                    style: isMe!
                        ? Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Theme.of(context).scaffoldBackgroundColor)
                        : Theme.of(context).textTheme.bodyText2,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        time!,
                        style: TextStyle(
                          fontSize: 10.0,
                          color: isMe!
                              ? Colors.white.withOpacity(0.75)
                              : Theme.of(context).hintColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      isMe!
                          ? Icon(
                              Icons.check_circle,
                              color:
                                  isDelivered! ? Colors.blue : Colors.grey[300],
                              size: 12.0,
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
