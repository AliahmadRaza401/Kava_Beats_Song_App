
// import 'dart:developer';
// import 'package:alibhaiapp/models/adminVoteAddModel.dart';
// import 'package:alibhaiapp/widgets/app_toast.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class VoteServices {
//   static var errorMessage;
// // Create a CollectionReference called users that references the firestore collection
//   CollectionReference users = FirebaseFirestore.instance.collection('vote');

//   Future<void> addVote(
//     String voteId,
//     String voteName,
//     BuildContext context,
//   ) {
//     // Call the user's CollectionReference to add a new user
//     return users.add({
//       'voteName': voteName.toUpperCase(),
//       'votingDate': DateTime.now(),
//       'totalVote': 0,
//       'voteId': voteId,
//     }).then((value) {
//       AppToast('Vote  Added', true);
//     }).catchError((error) {
//       AppToast('Vote Not Added', false);
//     });
//   }

//   Future<void> updateUser(
//     String updateVoteName,
//     String docId,
//     BuildContext context,
//   ) {
//     return users.doc(docId).update({'voteName': updateVoteName}).then((value) {
//       AppToast('Vote  Updated', true);
//       Navigator.of(context).pop();
//     }).catchError((error) {
//       log("Failed to update user: $error");
//     });
//   }

//   Future<void> SelectVoteByUser(
//     String docID,
//     String totalVote,
//     BuildContext context,
//   ) {
//     // Call the user's CollectionReference to add a new user
//     return FirebaseFirestore.instance.collection('vote').doc(docID).update({
//       'votingDate': DateTime.now(),
//       'totalVote': totalVote,
//     }).then((value) {
//       AppToast('Vote Submitted', true);
//     }).catchError((error) {
//       AppToast('Vote Not Submitted', false);
//     });
//   }

//   Future<void> deleteChar(
//     String docID,
//     BuildContext context,
//   ) {
//     // Call the user's CollectionReference to add a new user
//     return FirebaseFirestore.instance.collection('vote').doc(docID).delete();
//   }
  
// }
