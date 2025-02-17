import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WebRTCParent {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RTCPeerConnection? _peerConnection;
  MediaStream? _remoteStream;
  String roomId = "audio_room";

  Future<void> joinCall() async {
    var config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ]
    };

    _peerConnection = await createPeerConnection(config);

    // Listen for incoming audio
    _peerConnection!.onTrack = (RTCTrackEvent event) {
      _remoteStream = event.streams[0];
    };

    // Listen for ICE candidates and send to Firestore
    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      _firestore.collection("calls/$roomId/candidates").add(candidate.toMap());
    };

    // Fetch the offer from Firestore
    var callDoc = await _firestore.collection("calls").doc(roomId).get();
    if (callDoc.exists && callDoc.data()!.containsKey('offer')) {
      RTCSessionDescription offer = RTCSessionDescription(
        callDoc.data()!['offer']['sdp'],
        callDoc.data()!['offer']['type'],
      );
      await _peerConnection!.setRemoteDescription(offer);

      // Create answer
      RTCSessionDescription answer = await _peerConnection!.createAnswer();
      await _peerConnection!.setLocalDescription(answer);
      await _firestore.collection("calls").doc(roomId).update({'answer': answer.toMap()});
    }
  }

  // Listen for ICE candidates from child
  Future<void> listenForICECandidates() async {
    _firestore.collection("calls/$roomId/candidates").snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          var data = change.doc.data();
          RTCIceCandidate candidate = RTCIceCandidate(data?['candidate'], data?['sdpMid'], data?['sdpMLineIndex']);
          _peerConnection!.addCandidate(candidate);
        }
      }
    });
  }
}
