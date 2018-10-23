
class TodoBloc {
  String id;
  bool done;
  DateTime created;
  DateTime ended;
  String title;
  String description;

  TodoBloc(this.id, this.done, this.created, this.ended, this.title,
      this.description);
}