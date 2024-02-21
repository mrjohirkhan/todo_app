import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/tode_model.dart';
import 'package:todo/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final _textControler = TextEditingController();

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);

    Future<void> _showDialog() async {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Add To Do Item'),
              content: TextField(
                controller: _textControler,
                decoration: InputDecoration(
                  hintText: 'Write To Do List',
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (_textControler.text.isEmpty) {
                        return;
                      }

                      context.read<TodoProvider>().addTodoList(TODOModel(
                          isCompleted: false, title: _textControler.text));

                      _textControler.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Submit'))
              ],
            );
          });
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text('TO DO LIST'),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            PopupMenuButton(itemBuilder: (context) {
              return [PopupMenuItem(child: Text('All History'),value: 'All History',),
                PopupMenuItem(child: Text('Help & Feedback'),value: 'Help & Feedback',),
              ];
            },offset: Offset(50, 50),)
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.cyan,
                ),
                  currentAccountPicture: CircleAvatar(
                    foregroundImage: NetworkImage(''),
                  ),
                  accountName: Text('MD.JOHIRUL ISLAM'),
                  accountEmail: Text('mdjohiruli826@gmail.com'),
              ),
              ListTile(
                onTap: (){ Navigator.pop(context);},
                leading: Icon(Icons.home),
                title: Text('Home Page'),
              ),
              ListTile(
                onTap: (){Navigator.pop(context); },
                leading: Icon(Icons.person),
                title: Text('Profile'),
              ),
              ListTile(
                onTap: (){Navigator.pop(context);},
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ],
          )
        ),
        body: Column(
          children: [
            Expanded(
                flex: 5,
                child: ListView.builder(
                  itemBuilder: (context, itemIndex) {
                    return ListTile(
                      onTap: () {
                        provider.checkStatus(provider.alltodoList[itemIndex]);
                      },
                      leading: MSHCheckbox(
                        size: 20,
                        value: provider.alltodoList[itemIndex].isCompleted,
                        colorConfig:
                            MSHColorConfig.fromCheckedUncheckedDisabled(
                                checkedColor: Colors.blue),
                        style: MSHCheckboxStyle.stroke,
                        onChanged: (bool selected) {
                          provider.checkStatus(provider.alltodoList[itemIndex]);
                        },
                      ),
                      title: Text(
                        provider.alltodoList[itemIndex].title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration:
                                provider.alltodoList[itemIndex].isCompleted ==
                                        true
                                    ? TextDecoration.lineThrough
                                    : null),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          provider
                              .removedTodoList(provider.alltodoList[itemIndex]);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                  itemCount: provider.alltodoList.length,
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan,
          onPressed: () {
            _showDialog();
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
