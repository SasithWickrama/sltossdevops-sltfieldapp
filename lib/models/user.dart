class Users {
  String? sid;
  String? name;
  String? contact;
  List<dynamic>? rtarea;
  List<dynamic>? module;

  Users(
      {this.sid,
        this.name,
        this.contact,
        this.rtarea,
        this.module});

  Users.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    name = json['name'];
    contact = json['contact'];
    rtarea = json['rtarea'];
    module = json['module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['name'] = this.name;
    data['contact'] = this.contact;
    data['rtarea'] = this.rtarea;
    data['module'] = this.module;
    return data;
  }
}