import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgs/RankingScreen.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSelected = true;
  PageController controller

  Drawer getNavDrawer(BuildContext context) {
    var aboutChild = AboutListTile(
        child: prefix.Text("About"),
        applicationName: "Application Name",
        applicationVersion: "v1.0.0",
        applicationIcon: Icon(Icons.adb),
        icon: Icon(Icons.info));

    var myNavChildren = [
      Container(
        height: 200,
        width: double.infinity,
        color: Colors.blue,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              CircleAvatar(
                child: Icon(
                  Icons.account_circle,
                  size: 60,
                ),
                radius: 30,
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 4,),
                    prefix.Text(
                      'Mohamed Khaled',
                      style: TextStyle(
                        fontFamily: 'MontserratMedium',
                        fontSize: 20,
                        color: const Color.fromRGBO(38, 38, 47, 1),
                      ).apply(fontSizeDelta: -2, color: Colors.white),
                    ),
                    SizedBox(height: 4,),
                    prefix.Text(
                      '250 points',
                      style: TextStyle(
                        fontFamily: 'MontserratMedium',
                        fontSize: 16,
                        color: const Color.fromRGBO(38, 38, 47, 1),
                      ).apply(fontSizeDelta: -2, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      ListTile(
        title: prefix.Text('Air Poluttion'),
        leading: Icon(FontAwesomeIcons.airbnb),
      ),
      ListTile(
        title: prefix.Text('Water Poluttion'),
        leading: Icon(FontAwesomeIcons.water),
      ),
      ListTile(
        title: prefix.Text('Water Chemical'),
        leading: Icon(FontAwesomeIcons.airbnb),
      ),
      ListTile(
        title: prefix.Text('Plastic'),
        leading: Icon(Icons.nature_people),
      ),
      aboutChild
    ];

    return Drawer(
        child: Column(
      children: myNavChildren,
    ));
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: prefix.Text('SDGs')),
      drawer: getNavDrawer(context),
      body: PageView(controller: controller,children: <Widget>[Center(child: Text('To Do List'),),RankingScreen()],),
      bottomNavigationBar: Row(
        children: <Widget>[
          _BottomNavigationButton(
            'assets/flare/TasksIcon.flr',
            label: 'Actions',
            tap: () {
              controller.animateTo(1, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
              setState(() {
                isSelected = !isSelected;
              });            },
            isSelected: !isSelected,
            hasNotification: isSelected,
            iconSize: const Size(24, 25),
            padding: const EdgeInsets.only(top: 15),
          ),
          _BottomNavigationButton(
            'assets/flare/TeamIcon.flr',
            label: 'Ranking',
            tap: () {
              controller.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
              setState(() {
                isSelected = !isSelected;
              });
            },
            isSelected: isSelected,
            hasNotification: !isSelected,
            iconSize: const Size(25, 29),
            padding: const EdgeInsets.only(top: 10),
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationButton extends StatefulWidget {
  final bool hasNotification;
  final String flare;
  final Size iconSize;
  final bool isSelected;
  final EdgeInsets padding;
  final VoidCallback tap;
  final String label;

  const _BottomNavigationButton(this.flare,
      {this.isSelected = false,
      this.hasNotification = false,
      this.padding = const EdgeInsets.only(top: 15),
      this.iconSize = const Size(25, 29),
      this.tap,
      this.label});

  @override
  __BottomNavigationButtonState createState() =>
      __BottomNavigationButtonState();
}

class __BottomNavigationButtonState extends State<_BottomNavigationButton> {
  /// We use this variable as a way to determine if this is the first time the
  /// button is being shown.
  /// If that's the case, we simply pop to the last frame of the animation
  /// instead of playing it through.
  /// This prevents all of the bottom navigation buttons from playing an
  /// 'intro' animation when the screen is first displayed.
  bool _isFirstShow = true;

  @override
  void didUpdateWidget(_BottomNavigationButton oldWidget) {
    setState(() {
      _isFirstShow = false;
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        type: MaterialType.canvas,
        color: widget.isSelected
            ? const Color.fromRGBO(48, 48, 59, 1)
            : const Color.fromRGBO(38, 38, 47, 1),
        child: InkWell(
          onTap: widget.tap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                overflow: Overflow.visible,
                children: [
                  Padding(
                    padding: widget.padding,
                    child: SizedBox(
                      width: widget.iconSize.width,
                      height: widget.iconSize.height,
                      child: FlareActor(widget.flare,
                          alignment: Alignment.center,
                          shouldClip: false,
                          fit: BoxFit.contain,
                          snapToEnd: _isFirstShow,
                          animation: widget.isSelected ? 'active' : 'inactive'),
                    ),
                  ),
                  Positioned(
                    top: -20,
                    right: -15,
                    child: widget.hasNotification
                        ? const SizedBox(
                            width: 31,
                            height: 31,
                            child: FlareActor(
                                'assets/flare/NotificationIcon.flr',
                                alignment: Alignment.center,
                                shouldClip: false,
                                fit: BoxFit.contain,
                                animation: 'appear'),
                          )
                        : Container(),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5, bottom: MediaQuery.of(context).padding.bottom + 10),
                child: prefix.Text(
                  widget.label,
                  style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    fontSize: 16,
                    color: const Color.fromRGBO(38, 38, 47, 1),
                  ).apply(
                    fontSizeDelta: -2,
                    color: widget.isSelected
                        ? Colors.white
                        : Colors.white.withOpacity(0.35),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
