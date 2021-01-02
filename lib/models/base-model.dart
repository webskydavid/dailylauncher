enum ModelType {
  gracery,
  todo,
  event,
}

class BaseModel {
  ModelType _modelType;
  String id;
  String name;
  DateTime created;
  DateTime updated;

  BaseModel({
    this.id,
    this.name,
    this.created,
    this.updated,
  }) {
    this.id = id ?? '';
    this.name = name ?? '';
    this.created = created ?? DateTime.now();
    this.updated = updated ?? DateTime.now();
  }

  BaseModel.fromMap(Map<dynamic, dynamic> map) {
    print(map['created']);
    id = map['id'];
    name = map['name'];
    created = DateTime.parse(map['created']);
    updated = DateTime.parse(map['updated']);
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created'] = this.created.toString();
    data['updated'] = this.updated.toString();
    return data;
  }

  @override
  String toString() {
    return this.toMap().toString();
  }
}

class TodoModel extends BaseModel {}
