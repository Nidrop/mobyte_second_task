import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:mobyte_second_task/domain/task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'todos_database.g.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 128)();
  BoolColumn get isCompleted => boolean()();
  //TextColumn get content => text().named('body')();
  DateTimeColumn get deadline => dateTime()();
}

@DriftDatabase(tables: [Todos])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> addTodo(Task task) async {
    await into(todos).insert(
      TodosCompanion.insert(
        title: task.title,
        isCompleted: task.isCompleted,
        deadline: task.deadline,
      ),
    );
  }

  Future<List<Task>> getTasks() async {
    final todosQuery = await select(todos).get();
    List<Task> result = [];
    for (var element in todosQuery) {
      result.add(
        Task(
            title: element.title,
            deadline: element.deadline,
            isCompleted: element.isCompleted),
      );
    }
    return result;
  }

  Future<void> updateStatus(Task task) async {
    (update(todos)..where((t) => t.title.equals(task.title))).write(
      TodosCompanion(
        isCompleted: Value(task.isCompleted),
      ),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'todos.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
