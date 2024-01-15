class Modified {
  String? time;

  Modified({this.time});

  Modified.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['time'] = time;
    return data;
  }
}

class Movie {
  Modified? modified;
  String? id;
  String? name;
  String? slug;
  String? originname;
  String? thumburl;
  String? posterurl;
  int? year;

  Movie(
      {this.modified,
      this.id,
      this.name,
      this.slug,
      this.originname,
      this.thumburl,
      this.posterurl,
      this.year});

  Movie.fromJson(Map<String, dynamic> json) {
    modified =
        json['modified'] != null ? Modified?.fromJson(json['modified']) : null;
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    originname = json['origin_name'];
    thumburl = json['thumb_url'];
    posterurl = json['poster_url'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['modified'] = modified!.toJson();
    data['_id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['origin_name'] = originname;
    data['thumb_url'] = thumburl;
    data['poster_url'] = posterurl;
    data['year'] = year;
    return data;
  }
}
