// // import 'dart:developer';

// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';

// // class DownloadImage extends StatelessWidget {
// //   const DownloadImage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Image(
// //       image: Image.memory(),
// //       loadingBuilder: (context, child, loadingProgress) {

// //       },
// //     );
// //   }
// // }

// // String fileUrl =
// //     'https://firebasestorage.googleapis.com/v0/b/chat-app-3236e.appspot.com/o/chats%2FKA5AaYETiPnZq6Y2glZB%2Fpn993AKenlMhLOnaqLDR6BAlxXp11672424176913180.jpg?alt=media&token=5ef30952-3785-4a12-b11f-df115f733693';

// // String savePath = '/storage/emulated/0/Download/file.zip';

// // void downloadFile() async {
// //   Dio dio = Dio();

// //   try {
// //     // Start the download task
// //     Response response = await dio.download(fileUrl, savePath, onReceiveProgress: onProgressChange);

// //     print('File saved to ${response.realUri}');
// //   } catch (e) {
// //     log(e.toString());
// //   }
// // }

// // void onProgressChange(int received, int total) {
// //   // Calculate and display the download progress
// //   double progress = (received / total * 100).toDouble();
// //   log('Progress: $progress%');
// // }

// // ignore_for_file: depend_on_referenced_packages

// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// class ServerLocalImage extends StatefulWidget {
//   const ServerLocalImage({required this.url, super.key});
//   final String url;

//   @override
//   State<ServerLocalImage> createState() => _ServerLocalImageState();
// }

// class _ServerLocalImageState extends State<ServerLocalImage> {
//   late final String url;
//   late final String filename;
//   late Uint8List dataBytes;

//   @override
//   void initState() {
//     super.initState();
//     url = widget.url;
//     // filename = Uri.parse(url).pathSegments.last;
//     filename = 'image2.jpeg';
//     // downloadImage().then((bytes) {
//     //   setState(() {
//     //     dataBytes = bytes;
//     //   });
//     // });
//   }

//   // Future<Uint8List> downloadImage() async {
//   //   String dir = (await getExternalStorageDirectory())!.path;
//   //   File file = File('$dir/$filename');

//   //   if (file.existsSync()) {
//   //     log('file already exist');
//   //     var image = await file.readAsBytes();
//   //     return image;
//   //   } else {
//   //     var request = await http.get(Uri.parse(url));

//   //     //close();
//   //     Uint8List bytes = request.bodyBytes;

//   //     await file.writeAsBytes(bytes);
//   //     log(file.path);
//   //     return bytes;
//   //   }
//   // }

// // ...

//   Future<Stream<Uint8List>> downloadImage() async {
//     // Create a Dio HTTP client
//     Dio dio = Dio();
//     String dir = (await getExternalStorageDirectory())!.path;
//     File file = File('$dir/$filename');
//     // Start the download task
//     Response response = await dio.download(
//       url,
//       file.path,
//       options: Options(responseType: ResponseType.stream),
//     );
//     log(response.data.runtimeType.toString());
//     return (response.data as ResponseBody).stream;

//     // Close the stream when the download is complete
//     // yield* response.data;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TO DO: implement build

//     // return FadeInImage.memoryNetwork(
//     //   placeholder: dataBytes,
//     //   image: url,
//     //   fadeInDuration: const Duration(milliseconds: 500),
//     //   fadeOutDuration: const Duration(milliseconds: 500),
//     //   fit: BoxFit.cover,
//     //   width: 200.0,
//     //   height: 200.0,
//     // );

//     return FutureBuilder(
//       future: downloadImage(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator();
//         }
//         return StreamBuilder(
//           stream: snapshot.data,
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: Text('stream not started'),
//               );
//             }

//             // if (dataBytes != null) {
//             return Image.memory(snapshot.data);
//             // } else {
//             return const CircularProgressIndicator();
//             // }
//           },
//         );
//       },
//     );
//   }
// }
