import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File? image;
  final picker_gallery = ImagePicker();
  final picker_camera = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData &&
              snapshot.data!.docs != null &&
              snapshot.data!.docs.length > 0) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var post = snapshot.data!.docs[index];
                      return ListTile(
                          leading: Text(post['weight'].toString()),
                          title: Text(post['title']),
                          trailing: Image.network(post['url']));
                    },
                  ),
                ),
                ElevatedButton(
                  child: Text('Select photo and upload data'),
                  onPressed: () {
                    String source;
                    uploadData(source = 'get');
                  },
                ),
                ElevatedButton(
                  child: const Text('Take photo and upload data'),
                  onPressed: () {
                    String source;
                    uploadData(source = 'take');
                  },
                ),
                const SizedBox(height: 20,)
              ],
            );
          } else {
            return Column(
              children: [
                const Center(child: CircularProgressIndicator()),
                ElevatedButton(
                  child: const Text('Select photo and upload data'),
                  onPressed: () {
                    String source;
                    uploadData(source = 'get');
                  },
                ),
                ElevatedButton(
                  child: const Text('Take photo and upload data'),
                  onPressed: () {
                    String source;
                    uploadData(source = 'take');
                  },
                ),
                const SizedBox(height: 20,)
              ],
            );
          }
        });
  }


  // TODO handle live photos
  Future getImage() async {
    // TODO Add logic to handle user not allowing permission to access photos
    final pickedFile = await picker_gallery.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);

    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }


  Future takeImage() async {
    // TODO Add logic to handle user not allowing permission to access photos
    final pickedFile = await picker_camera.pickImage(source: ImageSource.camera);
    image = File(pickedFile!.path);

    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(image!);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    return url;
  }


  void uploadData(source) async {
    if(source == 'get') {
      final url = await getImage();
      final weight = DateTime.now().millisecondsSinceEpoch % 1000;
      final title = 'Title $weight';
      FirebaseFirestore.instance
          .collection('posts')
          .add({'weight': weight, 'title': title, 'url': url});
    } else {
      final url = await takeImage();
      final weight = DateTime.now().millisecondsSinceEpoch % 1000;
      final title = 'Title $weight';
      FirebaseFirestore.instance
          .collection('posts')
          .add({'weight': weight, 'title': title, 'url': url});
    }
  }
}