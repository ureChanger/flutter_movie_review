import 'package:flutter/material.dart';
import 'list_page.dart';
import 'grid_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _seclectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie Review'),
        // leading: Icon(Icons.menu),

        actions: [
          PopupMenuButton(
            itemBuilder: (context){
              return [
                PopupMenuItem(value: 0, child: Text("예매율순")),
                PopupMenuItem(value: 1, child: Text("큐레이션")),
                PopupMenuItem(value: 2, child: Text("최신순")),
              ];
            },
            icon: Icon(Icons.sort),
            onSelected: (value){
              if(value==0) print("예매율순");
              else if(value==1) print("큐레이션");
              else print("최신순");
            },)
        ],

      ),
      body: Center(
        child: _buildPage(_seclectedTabIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.view_list), title: Text('list')),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), title: Text('Grid')),
        ],
        currentIndex: _seclectedTabIndex,
        onTap: (index){
          setState(() {
            _seclectedTabIndex = index;
            print("$_seclectedTabIndex Tab Clicked");
          });
        },
      ),
    );
  }
}

Widget _buildPage(index){
  if(index == 0)
    return ListPage();
  else
    return GridPage();
}