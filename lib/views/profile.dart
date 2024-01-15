import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../core/logic/dio_helper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                  onTap: () async {
                    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      imagePath = file.path;
                      print(imagePath);
                      print(imagePath!.split("/").last);
                      setState(() {});
                    }
                  },
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath!))
                        : NetworkImage(
                                "https://media.licdn.com/dms/image/C5603AQEySmuHB1EwKQ/profile-displayphoto-shrink_800_800/0/1516263018272?e=2147483647&v=beta&t=C3s-TRyWgxxoFnUPJ1C-8fKDWwE948wKvG3Oy5H1RFY")
                            as ImageProvider,
                  )),
              if (imagePath != null)
                FilledButton(
                  onPressed: () async {
                    DioHelper.send(
                      "login",
                      data: {
                        "phone": "966550011223344",
                        "password": "123456789",
                        "device_token": "test",
                        "type": Platform.operatingSystem,
                        "user_type":"client"
                      },
                    );
                  },
                  child: Text("Upload"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
