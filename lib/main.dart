import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/TaskModel.dart';
import 'package:mobile/constantes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController descricao = new TextEditingController();
  final form = GlobalKey<FormState>();
  List<TaskModel> listTaskModel = new List<TaskModel>();
  bool isUpdate = false;
  int idCurrent = null;

  @override
  void initState() {
    super.initState();
    getListTaskModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: [
              Form(
                  key: form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: descricao,
                        validator: (value) {
                          if (value == null || value == '' || value.isEmpty)
                            return 'Obrigatório informar';
                          else if (value.length < 3)
                            return 'Deve conter pelo menos 3 letras';
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              if (form.currentState.validate()){
                                if (isUpdate) {
                                  TaskModel model = TaskModel(id: idCurrent, descricao: descricao.text.toString());
                                  updateTask(model);

                                  setState(() {
                                    isUpdate = false;
                                  });
                                } else {
                                  TaskModel model = TaskModel(descricao: descricao.text.toString(), isFinished: 0);
                                  createTask(model);
                                }

                                setState(() {
                                  descricao.text = "";
                                });

                                getListTaskModel();
                              }
                            },
                            child: Text(isUpdate ? 'Alterar' : 'Salvar'),
                          ),

                          //CASO ESTEJA ALTERNADO MOSTRAR BOTÃO PARA CANCELAR ALTERAÇÃO
                          isUpdate ?
                          RaisedButton(
                            onPressed: () async {
                              setState(() {
                                isUpdate = false;
                                descricao.text = "";
                              });
                            },
                            child: Text('Cancelar'),
                            color: Colors.redAccent,
                          ): Container()
                        ],
                      )
                    ],
                  )),

              listTaskModel.length > 0 ?
              Column(
                children: [
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listTaskModel.length,
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(listTaskModel[index].descricao),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        isUpdate = true;
                                        descricao.text = listTaskModel[index].descricao;
                                        idCurrent = listTaskModel[index].id;
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      deleteTask(listTaskModel[index]);
                                      getListTaskModel();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(listTaskModel[index].isFinished == 1 ? Icons.check_box_outlined : Icons.check_box_outline_blank),
                                    onPressed: () {
                                      finishTask(listTaskModel[index]);
                                      getListTaskModel();
                                    },
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                  )
                ],
              ) : Container()
            ],
          ),
        )
    );
  }

  void getListTaskModel() async {
    await getTasks().then((value) => {
      listTaskModel = value
    }).catchError((onError) => {
      listTaskModel = List<TaskModel>()
    });

    setState(() {});
  }
}

Future<Database> finishTask(TaskModel model) async {
  try {
    final Database db = await _getDatabase();
    model.isFinished == 0 ? model.isFinished = 1 : model.isFinished = 0;
    await db.update(
      TABLE_NAME,
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  } catch (ex) {
    print(ex);
  }
}

Future<Database> _getDatabase() async {
  return openDatabase(
    join(await getDatabasesPath(), DATABASE_NAME),
    onCreate: (db, version) {
      return db.execute(CREATE_TASK_TABLE_SCRIPT);
    },
    version: 1,
  );
}

Future<List<TaskModel>> getTasks() async {
  try {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    },
    );
  } catch (ex) {
    print(ex);
    return new List<TaskModel>();
  }
}

Future createTask(TaskModel model) async {
  try {
    final Database db = await _getDatabase();
    var value = model.toMap();
    await db.insert(
        TABLE_NAME,
        value
    );
  } catch (ex) {
    print(ex);
    return;
  }
}

Future<TaskModel> updateTask(TaskModel model) async {
  try {
    final Database db = await _getDatabase();
    await db.update(
      TABLE_NAME,
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  } catch (ex) {
    print(ex);
  }
}

Future<TaskModel> deleteTask(TaskModel model) async {
  try {
    final Database db = await _getDatabase();
    await db.delete(
      TABLE_NAME,
      where: "id = ?",
      whereArgs: [model.id],
    );
  } catch (ex) {
    print(ex);
  }
}
