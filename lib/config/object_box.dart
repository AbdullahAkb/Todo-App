import '../models/todo_model.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Box<TodoModel> _todoModelBox;

  ObjectBox._init(Store store) {
    _todoModelBox = Box<TodoModel>(store);
  }

  static Future<ObjectBox> init() async {
    final store = await openStore();
    return ObjectBox._init(store);
  }

  insertTodoModel(TodoModel detail) {
    _todoModelBox.put(detail);
  }

  deleteAll() {
    _todoModelBox.removeAll();
  }

  Future<bool> editPlan(TodoModel data, int id) async {
    var query = _todoModelBox.query(TodoModel_.id.equals(id)).build();
    var details = await query.findFirst();
    details =
        TodoModel(date: data.date, id: id, title: data.title, body: data.body);
    _todoModelBox.put(details);
    print(details);
    return true;
  }

  bool deleteThePlan(int planId) {
    return _todoModelBox.remove(planId);
  }

  insertAllTodoModel(List<TodoModel> detail) {
    _todoModelBox.putMany(detail);
  }

  int getTodoModelCount() => _todoModelBox.count();

  Stream<List<TodoModel>> getAllTodoListStream() {
    return _todoModelBox
        .query()
        .watch(triggerImmediately: true)
        .map((event) => event.find());
  }
}
