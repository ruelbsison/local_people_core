import 'package:local_people_core/core.dart';
import 'package:flutter/material.dart';
import '../blocs/message_box_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    context.read<MessageBoxBloc>().add(LoadMessageBoxEvent());
    return Scaffold(
      //appBar: buildAppBar(),
      appBar: buildAppBar(context),
      //body: MessageBoxBody(),
      body: BlocProvider.value(
        value: context.read<MessageBoxBloc>(),
        child: BlocBuilder<MessageBoxBloc, MessageBoxState>(
          builder: (context, state) {
            if (state is MessageBoxLoading) {
              return LoadingWidget();
            } else if (state is MessageBoxInitial) {
              return LoadingWidget();
            } else if (state is LoadMessageBoxFailed) {
              return ErrorWidget('Error: $state');
            } else if (state is MessageBoxLoaded) {
              return MessageBoxBody(messages: state.messages,);
            }
            return ErrorWidget('Unhandle State $state');
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: theme.primaryColor,
      //   child: Icon(
      //     Icons.person_add_alt_1,
      //     color: Colors.white,
      //   ),
      // ),
      //bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBarWidget buildAppBar(BuildContext context) {
    return AppBarWidget(
      //appBarPreferredSize: Size.fromHeight(60.0),
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

  // AppBar buildAppBar() {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     title: Text("Chats"),
  //     actions: [
  //       IconButton(
  //         icon: Icon(Icons.search),
  //         onPressed: () {},
  //       ),
  //     ],
  //     /*bottom: Padding(
  //       padding: EdgeInsets.only(top: 16,left: 16,right: 16),
  //       child: TextField(
  //         decoration: InputDecoration(
  //           hintText: "Search...",
  //           hintStyle: TextStyle(color: Colors.grey.shade600),
  //           prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
  //           filled: true,
  //           fillColor: Colors.grey.shade100,
  //           contentPadding: EdgeInsets.all(8),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(20),
  //               borderSide: BorderSide(
  //                   color: Colors.grey.shade100
  //               )
  //           ),
  //         ),
  //       ),
  //     ),*/
  //   );
  //}
}
