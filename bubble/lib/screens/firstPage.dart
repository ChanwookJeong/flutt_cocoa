import 'package:bubble/commons/baseDrawer.dart';
import 'package:bubble/screens/chat_screen.dart';
import 'package:bubble/screens/third_testPage.dart';
import 'package:flutter/material.dart';
import '../commons/baseAppbar.dart';
import '../commons/bottmoNavigationaEx2.dart';
import 'animatedListSample.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class First_screen extends StatefulWidget {
  const First_screen({super.key});

  @override
  State<First_screen> createState() => _First_screenState();
}

class _First_screenState extends State<First_screen> {
  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false;
  var mini = false;
  var rmicons = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection = SpeedDialDirection.up;
  var buttonSize = const Size(56.0, 56.0);
  var childrenButtonSize = const Size(56.0, 56.0);
  var selectedfABLocation = FloatingActionButtonLocation.miniEndFloat;
  var items = [
    FloatingActionButtonLocation.startFloat,
    FloatingActionButtonLocation.startDocked,
    FloatingActionButtonLocation.centerFloat,
    FloatingActionButtonLocation.endFloat,
    FloatingActionButtonLocation.endDocked,
    FloatingActionButtonLocation.startTop,
    FloatingActionButtonLocation.centerTop,
    FloatingActionButtonLocation.endTop,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(appBar: AppBar(), title: 'hello ', center: true),
      drawer: BaseDrawer(),
      body: AnimatedListSample(),
      floatingActionButtonLocation: selectedfABLocation,
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        // / This is ignored if animatedIcon is non null
        // child: Text("open"),
        // activeChild: Text("close"),
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        mini: mini,
        openCloseDial: isDialOpen,
        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        dialRoot: customDialRoot
            ? (ctx, open, toggleChildren) {
                return ElevatedButton(
                  onPressed: toggleChildren,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22, vertical: 18),
                  ),
                  child: const Text(
                    "Custom Dial Root",
                    style: TextStyle(fontSize: 17),
                  ),
                );
              }
            : null,
        buttonSize:
            buttonSize, // it's the SpeedDial size which defaults to 56 itself
        // iconTheme: IconThemeData(size: 22),
        label:
            extend ? const Text("Open") : null, // The label of the main button.
        /// The active label of the main button, Defaults to label if not specified.
        activeLabel: extend ? const Text("Close") : null,

        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the SpeedDial childrens size
        childrenButtonSize: childrenButtonSize,
        visible: visible,
        direction: speedDialDirection,
        switchLabelPosition: switchLabelPosition,

        /// If true user is forced to close dial manually
        closeManually: closeManually,

        /// If false, backgroundOverlay will not be rendered.
        renderOverlay: renderOverlay,
        // overlayColor: Colors.black,
        // overlayOpacity: 0.5,
        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        useRotationAnimation: useRAnimation,
        tooltip: 'Open Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        // foregroundColor: Colors.black,
        // backgroundColor: Colors.white,
        // activeForegroundColor: Colors.red,
        // activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,
        shape: customDialRoot
            ? const RoundedRectangleBorder()
            : const StadiumBorder(),
        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.accessibility) : null,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: !rmicons ? '아이콘 비활성' : '아이콘 활성',
            onTap: () => setState(() => rmicons = !rmicons),
            onLongPress: () => debugPrint('FIRST CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.store) : null,
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: '방만들기',
            onTap: () => Navigator.pushNamed(context, '/makeStore'),
          ),
          SpeedDialChild(
            child: !rmicons ? const Icon(Icons.margin) : null,
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            label: '전체공지',
            visible: true,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(("Third Child Pressed")))),
            onLongPress: () => debugPrint('THIRD CHILD LONG PRESS'),
          ),
        ],
      ),
      bottomNavigationBar: bottmoNavigationaEx2(0),
    );
  }
}
