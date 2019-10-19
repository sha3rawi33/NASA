import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdgs/RankingScreen.dart';
import ''

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  PageController controller;
  final primary = Color(0xff696b9e);
  final secondary = Color(0xfff29a94);

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
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Mohamed Khaled',
                      style: TextStyle(
                        fontFamily: 'MontserratMedium',
                        fontSize: 20,
                        color: const Color.fromRGBO(38, 38, 47, 1),
                      ).apply(fontSizeDelta: -2, color: Colors.white),
                    ),
                    SizedBox(
                      height: 4,
                    ),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: index, keepPage: true);
  }

  void _showPageIndex(int index) {
    setState(() {
      this.index = index;
    });
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: prefix.Text('SDGs'),
          backgroundColor: primary,
        ),
        drawer: getNavDrawer(context),
        floatingActionButton: FloatingActionButton(
          backgroundColor: secondary,
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/chat-bot');
          },
          child: Icon(Icons.android),
        ),
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: <Widget>[HomeScreen(), RankingScreen()],
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _selectedIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) =>
              setState(() {
                _selectedIndex = index;
                _pageController.animateToPage(index,
                    duration: Duration(milliseconds: 300), curve: Curves.ease);
              }),
          items: [
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.red,
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.people),
                title: Text('Users'),
                activeColor: Colors.purpleAccent
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.message),
                title: Text('Messages'),
                activeColor: Colors.pink
            ),
            BottomNavyBarItem(
                icon: Icon(Icons.settings),
                title: Text('Settings'),
                activeColor: Colors.blue
            ),
          ],
        )
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
                    top: 5, bottom: MediaQuery
                    .of(context)
                    .padding
                    .bottom + 10),
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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      padding: EdgeInsets.only(left: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue[800],
                  Colors.blue[600],
                  Colors.blue[400],
                  Colors.blue[200],
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'News',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://cdn4.iconfinder.com/data/icons/gradient-5/50/436-512.png'),
                    ),
                    bottom: 0,
                    right: 0,
                  )
                ],
              ),
              width: 200,
              height: 120,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.blue[800],
                  Colors.blue[600],
                  Colors.blue[400],
                  Colors.blue[200],
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Problems',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Positioned(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUfhqlbrNkoSKEXpzuWeLLBhWThye2FA_3axpDRvT8mmGmD49_'),
                    ),
                    bottom: 0,
                    right: 0,
                  )
                ],
              ),
              width: 200,
              height: 120,
            ),
          ),
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue[800],
                      Colors.blue[600],
                      Colors.blue[400],
                      Colors.blue[200],
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Goals',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  width: 200,
                  height: 120,
                ),
              ),
              Positioned(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://sdghub.com/wp-content/uploads/2019/03/xWBCSD-6Programs-SDG-wheel.png.pagespeed.ic.Psqua9phzp.png'),
                ),
                bottom: 0,
                right: 0,
              )
            ],
          )
        ],
      ),
    );
  }
}
