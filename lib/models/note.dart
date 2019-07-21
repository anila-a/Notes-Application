class Note {
  int _id;
  String _title;
  String _description;
  String _date;

  Note(this._title, this._date, [this._description]);

  Note.withId(this._id, this._title, this._date, [this._description]);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get date => _date;

  // setter for id is generated automatically

  set title(String newTitle) {
    if (newTitle.length <= 150) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 150) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert an object into a Map object
  Map<String, dynamic> toMap() {
    // dynamic works for int and String as well
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;

    return map;
  }

  // Extract an object from a Map object
  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
  }
}
