import '../../model/songs/song.dart';

class SongDTO {
  static Song fromMap(Map<String, dynamic> map, String id) {
    return Song(
      id: id,
      title: map['title'] ?? '',
      artistId: map['artistId'] ?? '',
      duration: Duration(milliseconds: map['duration'] ?? 0),
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  static Map<String, dynamic> toMap(Song song) {
    return {
      'title': song.title,
      'artistId': song.artistId,
      'duration': song.duration.inMilliseconds,
      'imageUrl': song.imageUrl,
    };
  }
}
