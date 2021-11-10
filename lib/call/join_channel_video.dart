import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:doctoworld_doctor/call/agora.config.dart' as config;
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';


/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  // final channelId;
  // final listner;
  // JoinChannelVideo({this.channelId,this.listner});
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  late final RtcEngine _engine;

  bool isJoined = false, switchCamera = true, switchRender = true;
  List<int> remoteUid = [];


  @override
  void initState() {
    super.initState();

    this._initEngine();

  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(config.appId));
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
        if(remoteUid.length == 0){
          Get.offAll(Dashboard());

        }
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(
        Get.find<LoaderController>().agoraModel.token == null
            ?Get.find<LoaderController>().agoraModelDefault.token
            :Get.find<LoaderController>().agoraModel.token,
        Get.find<LoaderController>().agoraModel.channelName == null
            ?Get.find<LoaderController>().agoraModelDefault.channelName!
            :Get.find<LoaderController>().agoraModel.channelName!,
        null,
        Get.find<LoaderController>().callerType);
    this._addListeners();
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      log('switchCamera $err');
    });
  }

  _switchRender() {
    setState(() {
      switchRender = !switchRender;
      remoteUid = List.of(remoteUid.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _renderVideo();
  }
  void _onCallEnd(BuildContext context) {
    Navigator.pop(context);
  }
  bool muted = false;
  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }
  Widget _toolbar() {
    if (!isJoined) return Center(
      child: RawMaterialButton
        (
        onPressed: () =>_joinChannel(),
        child: Icon(
          Icons.call,
          color: Colors.white,
          size: 35.0,
        ),
        shape: CircleBorder(),
        elevation: 2.0,
        fillColor: Colors.green,
        padding: const EdgeInsets.all(15.0),
      ),
    );
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () {
              _leaveChannel();
              _onCallEnd(context);
            },
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }
  _renderVideo() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: SafeArea(
        child: Stack(
          children: [
            remoteUid.length == 0
                ?Container(color: Colors.grey,)
                :RtcRemoteView.SurfaceView(
              uid: remoteUid[0],
            ),
            Container(
              width: 120,
              height: 120,
              child: RtcLocalView.SurfaceView(),

            ),

            // Align(
            //   alignment: Alignment.topLeft,
            //   child: SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: List.of(remoteUid.map(
            //         (e) => GestureDetector(
            //           onTap: this._switchRender,
            //           child: Container(
            //             width: 120,
            //             height: 120,
            //             child: RtcLocalView.SurfaceView(),
            //           ),
            //         ),
            //       )),
            //     ),
            //   ),
            // ),
            _toolbar()
          ],
        ),
      ),
    );
  }
}
