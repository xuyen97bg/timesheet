class Project {
  String? id;
  String? name;
  String? code;
  String? status;
  String? description;
  String? tasks;

  Project(
      {this.id,
        this.name,
        this.code,
        this.status,
        this.description,
        this.tasks});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    code = json['code'] ?? '';
    status = json['status'] ?? '';
    description = json['description'] ?? '';
    tasks = json['tasks'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['status'] = this.status;
    data['description'] = this.description;
    data['tasks'] = this.tasks;
    return data;
  }
}