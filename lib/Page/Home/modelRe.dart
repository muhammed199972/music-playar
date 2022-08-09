class Re {
  List<Data> data;

  Re({this.data});

  Re.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String name;
  String image;
  String artists;
  String spotify;

  Data({this.name, this.image, this.artists});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    artists = json['artists'];
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['artists'] = this.artists;
    data['spotify'] = this.spotify;
    return data;
  }
}
