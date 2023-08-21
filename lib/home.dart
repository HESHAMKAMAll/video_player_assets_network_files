import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController controller;
  late VideoPlayerController networkController;
  late VideoPlayerController fileController;

  @override
  void initState() {
    // from assets.
    controller = VideoPlayerController.asset("assets/1.mp4")
      ..initialize().then((_) {
        controller.setLooping(true);
        setState(() {});
      });
    // from network.
    networkController = VideoPlayerController.networkUrl(Uri.parse(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4"))
      ..initialize().then((_) {
        networkController.setLooping(true);
        setState(() {});
      });
    // from files.
    fileController = VideoPlayerController.file(File(""))..initialize().then((_) {setState(() {});});
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    networkController.dispose();
    fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // from assets.
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (controller.value.isPlaying) {
                    setState(() {
                      controller.pause();
                    });
                  } else {
                    setState(() {
                      controller.play();
                    });
                  }
                },
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
              const Text("Video From Assets",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.deepPurple,
                    bufferedColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Duration? value = await controller.position;
                  var newValue = value! - const Duration(seconds: 5);
                  controller.seekTo(newValue);
                  setState(() {});
                },
                child: const Text("<<"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.value.isPlaying) {
                      setState(() {
                        controller.pause();
                      });
                    } else {
                      setState(() {
                        controller.play();
                      });
                    }
                  },
                  child: controller.value.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Duration? value = await controller.position;
                  var newValue = value! + const Duration(seconds: 5);
                  controller.seekTo(newValue);
                  setState(() {});
                },
                child: const Text(">>"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.value.volume == 0) {
                      controller.setVolume(1);
                      setState(() {});
                    } else {
                      controller.setVolume(0);
                      setState(() {});
                    }
                  },
                  child: controller.value.volume == 0
                      ? const Icon(Icons.volume_off)
                      : const Icon(Icons.volume_up),
                ),
              ),
            ],
          ),
          const Divider(endIndent: 50, indent: 50),
          // from network.
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (networkController.value.isPlaying) {
                    setState(() {
                      networkController.pause();
                    });
                  } else {
                    setState(() {
                      networkController.play();
                    });
                  }
                },
                child: AspectRatio(
                  aspectRatio: networkController.value.aspectRatio,
                  child: VideoPlayer(networkController),
                ),
              ),
              const Text("Video From Internet",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  networkController,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.deepPurple,
                    bufferedColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  Duration? value = await networkController.position;
                  var newValue = value! - const Duration(seconds: 5);
                  networkController.seekTo(newValue);
                  setState(() {});
                },
                child: const Text("<<"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (networkController.value.isPlaying) {
                      setState(() {
                        networkController.pause();
                      });
                    } else {
                      setState(() {
                        networkController.play();
                      });
                    }
                  },
                  child: networkController.value.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Duration? value = await networkController.position;
                  var newValue = value! + const Duration(seconds: 5);
                  networkController.seekTo(newValue);
                  setState(() {});
                },
                child: const Text(">>"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (networkController.value.volume == 0) {
                      networkController.setVolume(1);
                      setState(() {});
                    } else {
                      networkController.setVolume(0);
                      setState(() {});
                    }
                  },
                  child: networkController.value.volume == 0
                      ? const Icon(Icons.volume_off)
                      : const Icon(Icons.volume_up),
                ),
              ),
            ],
          ),
          const Divider(endIndent: 50, indent: 50),
          // from files.
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  if (fileController.value.isPlaying) {
                    setState(() {
                      fileController.pause();
                    });
                  } else {
                    setState(() {
                      fileController.play();
                    });
                  }
                },
                child: AspectRatio(
                  aspectRatio: fileController.value.aspectRatio,
                  child: VideoPlayer(fileController),
                ),
              ),
              const Text("Video From Files",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: VideoProgressIndicator(
                  fileController,
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: Colors.deepPurple,
                    bufferedColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final file = await pickFile();
                    if(file != null){
                      fileController = VideoPlayerController.file(file).initialize().then((_){
                        setState(() {});
                      }) as VideoPlayerController;
                    }
                  },
                  child: const Icon(Icons.video_library),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Duration? value = await fileController.position;
                  var newValue = value! - const Duration(seconds: 5);
                  fileController.seekTo(newValue);
                  setState(() {});
                },
                child: const Text("<<"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (fileController.value.isPlaying) {
                      setState(() {
                        fileController.pause();
                      });
                    } else {
                      setState(() {
                        fileController.play();
                      });
                    }
                  },
                  child: fileController.value.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Duration? value = await fileController.position;
                  var newValue = value! + const Duration(seconds: 5);
                  fileController.seekTo(newValue);
                  setState(() {});
                },
                child: const Text(">>"),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (fileController.value.volume == 0) {
                      fileController.setVolume(1);
                      setState(() {});
                    } else {
                      fileController.setVolume(0);
                      setState(() {});
                    }
                  },
                  child: fileController.value.volume == 0
                      ? const Icon(Icons.volume_off)
                      : const Icon(Icons.volume_up),
                ),
              ),
            ],
          ),
          const Divider(endIndent: 50, indent: 50),
        ],
      ),
    );
  }
  pickFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.video);
    if(result != null){
      return File(result.files.single.path.toString());
    }
  }
}
