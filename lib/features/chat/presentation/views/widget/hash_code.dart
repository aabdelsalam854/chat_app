/*class ExternalData {
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection('categories');
  Reference get firebaseStorage => FirebaseStorage.instance.ref();
  List<CategoryyModel> categoryDataList = [];

  Future<List<CategoryyModel>> getCategoriesData() async {
    try {
      List<QueryDocumentSnapshot> categoryDataQueryList = [];
      categoryDataList.clear();
      QuerySnapshot querySnapshot = await _categories.get();
      categoryDataQueryList.addAll(querySnapshot.docs);
      for (int i = 0; i < categoryDataQueryList.length; i++) {
        String? x = await getCategorisImg(categoryDataQueryList[i]['logoIMG']);
        categoryDataList
            .add(CategoryyModel.fromFirebase(categoryDataQueryList[i], x!));
      }
      return categoryDataList;
    } catch (e, stackTrace) {
      Logger().e('Error getting categories data', e, stackTrace);
      return [];
    }
  }*/
/*
  Future<String?> getCategorisImg(String img) async {
    try {
      var urlRef = firebaseStorage.child('images').child(img);
      var imgUrl = await urlRef.getDownloadURL();
      Logger().i('Image URL: $imgUrl');
      return imgUrl;
    } catch (e, stackTrace) {
      Logger().e('Error getting image URL', e, stackTrace);
      return null;
    }
  }
}*/
/*
class Externaldata {
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection('categories');
  Reference get firebaseStorage => FirebaseStorage.instance.ref();
  List<CategoryyModel> categoryDataList = [];
  Future<List<CategoryyModel>> getCategoriesData() async {
    try {
      List<QueryDocumentSnapshot> categoryDataQueryList = [];
      categoryDataList.clear();
      QuerySnapshot querySnapshot = await _categories.get();
      categoryDataQueryList.addAll(querySnapshot.docs);
      for (int i = 0; i < categoryDataQueryList.length; i++) {
        String? x = await getCategorisImg(categoryDataQueryList[i]['logoIMG']);
        categoryDataList
            .add(CategoryyModel.fromFirebase(categoryDataQueryList[i], x!));
      }
      return categoryDataList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  */
/*
  Future<String?> getCategorisImg(String img) async {
    try {
      var urlRef = firebaseStorage.child('images').child(img);
      var imgUrl = await urlRef.getDownloadURL();
      print(imgUrl);
      return imgUrl;
    } catch (e) {
      print(e);
    }
    return null;
  }
}*/
/*
class ExternalData {
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection('categories');
  Reference get firebaseStorage => FirebaseStorage.instance.ref();
  List<CategoryyModel> categoryDataList = [];

  Future<List<CategoryyModel>> getCategoriesData() async {
    try {
      categoryDataList.clear();
      QuerySnapshot querySnapshot = await _categories.get();
      List<CategoryyModel> categories = await Future.wait(querySnapshot.docs.map((doc) async {
        String? imgUrl = await getCategorisImg(doc['logoIMG']);
        return CategoryyModel.fromFirebase(doc, imgUrl!);
      }));
      categoryDataList.addAll(categories);
      return categoryDataList;
    } catch (e, stackTrace) {
      Logger().e('Error getting categories data', e, stackTrace);
      return [];
    }
  }

  Future<String?> getCategorisImg(String img) async {
    try {
      var urlRef = firebaseStorage.child('images').child(img);
      var imgUrl = await urlRef.getDownloadURL();
      Logger().i('Image URL: $imgUrl');
      return imgUrl;
    } catch (e, stackTrace) {
      Logger().e('Error getting image URL', e, stackTrace);
      return null;
    }
  }
}*/
/*
عرض ملف pdf
  PDFView showPdf() {
    return PDFView(
      filePath: pickedFile!.path,
      enableSwipe: false,
      autoSpacing: false,
      pageFling: false,
      onError: (error) {
        log(error.toString());
      },
      onPageError: (page, error) {
        log('$page: ${error.toString()}');
      },
    );
  }
*/
/*
تحدديد نوع الملف وعرضه 
     Widget isFile;
    if (pickedFile!.extension == 'pdf') {
      isFile = showPdf();
    } else if (pickedFile!.extension == 'doc' ||
        pickedFile!.extension == 'docx') {
      isFile = FileTipe(
        pickedFile: pickedFile,
        image: 'assets/images/docx.png',
      );
    } else if (pickedFile!.extension == 'mp4') {
      isFile = FileTipe(
        pickedFile: pickedFile,
        image: 'assets/images/mp4.png',
      );
    } else if (pickedFile!.extension == 'jpg') {
      isFile = FileTipe(pickedFile: pickedFile, image: 'assets/images/jpg.png');
    } else if (pickedFile!.extension == 'png') {
      isFile = FileTipe(pickedFile: pickedFile, image: 'assets/images/png.png');
    } else {
      isFile = showPdf();
    }
    String extension = pickedFile!.extension!.toLowerCase();
    String image = 'assets/images/$extension.png';
    if (extension == 'doc' ||
        extension == 'docx' ||
        extension == 'mp4' ||
        extension == 'jpg' ||
        extension == 'png') {
      isFile = FileTipe(pickedFile: pickedFile, image: image);
    } else {
      isFile = showPdf();
    }

  */

    /*
    اختيرا ملف 
    Future<void> selectFile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (res == null) {
      return;
    }

    setState(() {});
  }
  */

 /*
اختيرا ملف 
 
  Future<void> selectFiles() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (res != null) {
      pickedFile = res.files.first;
    }
  }
  */

/*

    void showAndsends(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) {
        if (imagess == null) {
          Navigator.pop(context);
          return const SizedBox();
        } else {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image(
                    fit: BoxFit.cover,
                    image: FileImage(imagess!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomBottom(
                    text: 'Send',
                    onPressed: () async {
                      Navigator.pop(context);
                      final upDateurl = await UploadFileInFirebase.uploadFile(
                          File(imagess!.path));
                      await FireCloud.sendMessage(MessageModel(
                        message: upDateurl,
                        id: widget.email,
                        type: 'MessageType.image',
                        time: DateTime.now().toString(),
                      ));
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
*/