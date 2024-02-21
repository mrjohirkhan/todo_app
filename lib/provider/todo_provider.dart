import 'package:flutter/cupertino.dart';
import 'package:todo/model/tode_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TODOModel> _todoList=[];

  List<TODOModel> get alltodoList=>_todoList;

  void addTodoList(TODOModel todoModel){
    _todoList.add(todoModel);
    notifyListeners();
  }

  void removedTodoList(TODOModel todoModel){
    final index=_todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }

  void checkStatus(TODOModel todoModel){
    final index=_todoList.indexOf(todoModel);
    _todoList[index].toggleCompleted();
    notifyListeners();
  }
}