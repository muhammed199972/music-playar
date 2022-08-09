import 'dart:convert';

DeezerSongModel deezerSongModelFromJson(String str) =>
    DeezerSongModel.fromJson(json.decode(str));

String deezerSongModelToJson(DeezerSongModel data) =>
    json.encode(data.toJson());

class DeezerSongModel {
  DeezerSongModel({
    this.title,
    this.artist,
    this.album,
  });

  String title;
  Artist artist;
  Album album;

  DeezerSongModel copyWith({
    String title,
    Artist artist,
    Album album,
  }) =>
      DeezerSongModel(
        title: title ?? this.title,
        artist: artist ?? this.artist,
        album: album ?? this.album,
      );

  factory DeezerSongModel.fromJson(Map<String, dynamic> json) =>
      DeezerSongModel(
        title: json["title"] == null ? null : json["title"],
        artist: json["artist"] == null ? null : Artist.fromJson(json["artist"]),
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "artist": artist == null ? null : artist.toJson(),
        "album": album == null ? null : album.toJson(),
      };
}

class Album {
  Album({
    this.coverBig,
  });

  String coverBig;

  Album copyWith({
    String coverBig,
  }) =>
      Album(
        coverBig: coverBig ?? this.coverBig,
      );

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        coverBig: json["cover_big"] == null ? null : json["cover_big"],
      );

  Map<String, dynamic> toJson() => {
        "cover_big": coverBig == null ? null : coverBig,
      };
}

class Artist {
  Artist({
    this.name,
  });

  String name;

  Artist copyWith({
    String name,
  }) =>
      Artist(
        name: name ?? this.name,
      );

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}
