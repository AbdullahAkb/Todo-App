import 'package:objectbox/objectbox.dart';

@Entity()
class TodoModel {
  TodoModel({
    required this.date,
    required this.id,
    required this.title,
    required this.body,
  });

  late String title;
  @Id(assignable: false)
  int? id;
  late String body;
  late String date;

  TodoModel.autoId(
      {required this.title, required this.body, required this.date});
}
