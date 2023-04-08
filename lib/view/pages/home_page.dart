import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          backgroundImage: AssetImage("assets/profile.png"),
        ),
      ),
      body: ListView(
        children: List.generate(
          100,
              (int index) {
            return _listItem(index);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            label: "",
          ),
        ],
      ),
    );
  }

  Widget _listItem(int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/profile.png"),
      ),
      title: Text(
        "shogo.yamada",
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            "Hello!! This is Flutter create twitter ui. flutter is to easy the create ui",
            overflow: TextOverflow.clip,
            maxLines: 3,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Icon(Icons.comment),
              Icon(Icons.repeat),
              Icon(Icons.favorite_border),
              Icon(Icons.share),
            ],
          )
        ],
      ),
    );
  }
}