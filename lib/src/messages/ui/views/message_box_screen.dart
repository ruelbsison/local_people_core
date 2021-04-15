import 'package:local_people_core/core.dart';
import 'package:flutter/material.dart';

import '../widgets/message_box_body.dart';

class MessageBoxScreen extends StatefulWidget {
  @override
  _MessageBoxScreenState createState() => _MessageBoxScreenState();
}

class _MessageBoxScreenState extends State<MessageBoxScreen> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      //appBar: buildAppBar(),
      appBar: AppBarWidget(
        appBarPreferredSize: Size.fromHeight(70.0),
        /*title: Text(
            AppLocalizations.of(context).appTitle,
          ),*/
        subTitle: LocalPeopleLocalizations.of(context).menuTitleMessages,
        appBar: AppBar(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Color.fromRGBO(186, 207, 216, 1),
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: MessageBoxBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.primaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            //backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
