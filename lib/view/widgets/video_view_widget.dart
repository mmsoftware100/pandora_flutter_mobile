// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
//
// class VideoViewWidget extends StatefulWidget {
//   String videoName;
//   String videoUrl;
//   VideoViewWidget({Key? key,required this.videoName,required this.videoUrl}) : super(key: key);
//
//   @override
//   State<VideoViewWidget> createState() => _VideoViewWidgetState();
// }
//
// class _VideoViewWidgetState extends State<VideoViewWidget> {
//   late BetterPlayerController _betterPlayerController;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         widget.videoUrl
//     );
//     _betterPlayerController = BetterPlayerController(
//         const BetterPlayerConfiguration(
//           autoPlay: true,
//           fit: BoxFit.contain,
//           controlsConfiguration: BetterPlayerControlsConfiguration(
//             enableOverflowMenu: false,
//             showControlsOnInitialize: false,
//             enableRetry: true,
//             showControls: true,
//           ),
//         ),
//         // betterPlayerDataSource: BetterPlayerDataSource.network('http://samples.mplayerhq.hu/MPEG-4/embedded_subs/1Video_2Audio_2SUBs_timed_text_streams_.mp4'),
//         betterPlayerDataSource: betterPlayerDataSource
//     );
//
//     print(widget.videoUrl);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _betterPlayerController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.red,
//
//           title: Text(widget.videoName),
//         ),
//         body:  Center(
//           child: Container(
//             height: MediaQuery.of(context).size.height/3.3,
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child:BetterPlayer(controller: _betterPlayerController),//
//               // BetterPlayerPlaylist(
//               //     betterPlayerConfiguration: BetterPlayerConfiguration(),
//               //     betterPlayerPlaylistConfiguration:  BetterPlayerPlaylistConfiguration(),
//               //     betterPlayerDataSourceList: createDataSet()
//               // ),
//               //BetterPlayer(controller: _betterPlayerController),//
//             ),
//           ),
//         )
//     );
//   }
// }
