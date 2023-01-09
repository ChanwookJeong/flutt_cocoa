import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Third_testPage extends StatefulWidget {
  const Third_testPage({super.key});

  @override
  State<Third_testPage> createState() => _Third_testPageState();
}

class _Third_testPageState extends State<Third_testPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  void initState() {
    // VideoPlayerController를 저장하기 위한 변수를 만듭니다. VideoPlayerController는
    // asset, 파일, 인터넷 등의 영상들을 제어하기 위해 다양한 생성자를 제공합니다.
    _controller = VideoPlayerController.network(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'https://dm0qx8t0i9gc9.cloudfront.net/watermarks/video/HyK36gOdmjm0pmnp3/videoblocks-tropical-fishes-in-martinique-caribbean-sea-anse-dufour-yellow-shoal-of-fish_rkogt-idp__50d3d3eb12c85f3d87fe14d6d758a13f__P360.mp4',
    );

    // 컨트롤러를 초기화하고 추후 사용하기 위해 Future를 변수에 할당합니다.
    _initializeVideoPlayerFuture = _controller.initialize();

    // 비디오를 반복 재생하기 위해 컨트롤러를 사용합니다.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // 자원을 반환하기 위해 VideoPlayerController를 dispose 시키세요.
    _controller.dispose();

    super.dispose();
  }

  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: 450,
            width: double.infinity,
            child: Column(
              children: [
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
                      // VideoPlayer의 종횡비를 제한하세요.
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
                        child: VideoPlayer(_controller),
                      );
                    } else {
                      // 만약 VideoPlayerController가 여전히 초기화 중이라면,
                      // 로딩 스피너를 보여줍니다.
                      // return Center(child: CircularProgressIndicator());
                      return Center(child: spinkit);
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '이름 : 나비~~~~~~~~~~~~~~~~~``',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '이름 : 나비~~~~~~~~~~~~~~~~~``',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '이름 : 나비~~~~~~~~~~~~~~~~~``',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '이름 : 나비~~~~~~~~~~~~~~~~~``',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '이름 : 나비~~~~~~~~~~~~~~~~~``',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 10,
                    color: Colors.amber,
                  ),
                  label: Text('Close', style: TextStyle(color: Colors.amber)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // VideoPlayerController가 초기화를 진행하는 동안 로딩 스피너를 보여주기 위해
        // FutureBuilder를 사용합니다.
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  // _controller.pause();
                } else {
                  // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                  _controller.play();
                }
                showAlert(context);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.image,
                    color: Colors.cyan,
                  ),
                  Text('정보 확인'),
                ],
              ),
            ),
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // 만약 VideoPlayerController 초기화가 끝나면, 제공된 데이터를 사용하여
                  // VideoPlayer의 종횡비를 제한하세요.
                  return AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    // 영상을 보여주기 위해 VideoPlayer 위젯을 사용합니다.
                    child: VideoPlayer(_controller),
                  );
                } else {
                  // 만약 VideoPlayerController가 여전히 초기화 중이라면,
                  // 로딩 스피너를 보여줍니다.
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
            TextButton.icon(
              onPressed: () {
                // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
                // 보여집니다.
                setState(() {
                  // 영상이 재생 중이라면, 일시 중지 시킵니다.
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                    _controller.play();
                  }
                });
              },
              icon: Icon(
                // 플레이어의 상태에 따라 올바른 아이콘을 보여줍니다.
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 10,
                color: Colors.amber,
              ),
              label: _controller.value.isPlaying
                  ? Text('정지', style: TextStyle(color: Colors.amber))
                  : Text('시작', style: TextStyle(color: Colors.amber)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 재생/일시 중지 기능을 `setState` 호출로 감쌉니다. 이렇게 함으로써 올바른 아이콘이
            // 보여집니다.
            setState(() {
              // 영상이 재생 중이라면, 일시 중지 시킵니다.
              if (_controller.value.isPlaying) {
                _controller.pause();
              } else {
                // 만약 영상이 일시 중지 상태였다면, 재생합니다.
                _controller.play();
              }
            });
          },
          child: Icon(
            // 플레이어의 상태에 따라 올바른 아이콘을 보여줍니다.
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ), // 이 마지막 콤마는 build 메서드에 자동 서식이 잘 적용될 수 있도록 도와줍니다.
      ),
    );
  }
}
