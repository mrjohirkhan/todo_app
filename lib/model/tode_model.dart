class TODOModel{
  String title;
  bool isCompleted;

  TODOModel({required this.isCompleted,required this.title});

  void toggleCompleted(){
    isCompleted=!isCompleted;
  }
}