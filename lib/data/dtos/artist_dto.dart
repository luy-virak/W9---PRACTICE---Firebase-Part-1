import '../../model/artist/artist.dart';

class ArtistDTO {
  static Artist fromMap(Map<String, dynamic> map, String id) {
    return Artist(
      id: id,
      name: map['name'] ?? '',
      genre: map['genre'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(Artist artist) {
    return {
      'id': artist.id,
      'name': artist.name,
      'genre': artist.genre,
      'imageUrl': artist.imageUrl,
    };
  }
}
