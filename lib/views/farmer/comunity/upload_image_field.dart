import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_field/image_field.dart';
import 'package:image_field/linear_progress_indicator_if.dart';
import 'package:image_picker/image_picker.dart';

typedef Progress = Function(double percent);

class UploadImageField extends StatefulWidget {
  const UploadImageField({super.key});

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  final _formKey = GlobalKey<FormState>();

  dynamic remoteFiles;

  Future<dynamic> uploadToServer(XFile? file,
      {Progress? uploadProgress}) async {
    //implement your code using Rest API or other technology
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Remote Image upload
          Expanded(
            child: ImageField(
                texts: const {
                  'fieldFormText': 'Unggah Foto',
                  'titleText': 'Unggah Foto'
                },
                files: remoteFiles != null
                    ? remoteFiles!.map((image) {
                        return ImageAndCaptionModel(
                            file: image, caption: image.alt.toString());
                      }).toList()
                    : [],
                remoteImage: true,
                onUpload:
                    (pickedFile, controllerLinearProgressIndicator) async {
                  dynamic fileUploaded = await uploadToServer(
                    pickedFile,
                    uploadProgress: (percent) {
                      var uploadProgressPercentage = percent / 100;
                      controllerLinearProgressIndicator!
                          .updateProgress(uploadProgressPercentage);
                    },
                  );
                  return fileUploaded;
                },
                onSave: (List<ImageAndCaptionModel>? imageAndCaptionList) {
                  remoteFiles = imageAndCaptionList;
                }),
          ),
        ],
      ),
    );
  }
}
