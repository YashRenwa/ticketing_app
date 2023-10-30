import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ticketing_app/model/ticket_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TicketRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> setPermissions() async {
    var status = await Permission.notification.request();
    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<List<TicketModel>> getTickets() async {
    final response = await _firebaseFirestore.collection("tickets").get();
    List<TicketModel> tickets =
        response.docs.map((doc) => TicketModel.fromMap(doc.data())).toList();

    return tickets;
  }

  Future<void> setTokens() async {
    await FirebaseMessaging.instance.getToken().then((value) {
      var token = value!;
      _firebaseFirestore.collection("tokens").doc('all_tokens').update({
        'tokens': FieldValue.arrayUnion([token])
      });
    });
  }

  Future<String> addTicket(TicketModel ticket, File attachmentFile) async {
    try {
      final Reference storageRef = FirebaseStorage.instance.ref().child(
          'files/${attachmentFile.path.split('/')[attachmentFile.path.split('/').length - 1]}');
      final metadata = SettableMetadata(
        contentType: 'application/pdf',
        customMetadata: {
          'picked-file-path': attachmentFile.path
              .split('/')[attachmentFile.path.split('/').length - 1]
        },
      );
      // Upload the file to Firebase Storage
      await storageRef.putFile(attachmentFile, metadata);

      // Get the download URL of the uploaded file
      final String downloadURL = await storageRef.getDownloadURL();
      ticket.attachmentUrl = downloadURL;
      await _firebaseFirestore.collection("tickets").add(ticket.toMap());
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> getTicketFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    return file;
  }
}
