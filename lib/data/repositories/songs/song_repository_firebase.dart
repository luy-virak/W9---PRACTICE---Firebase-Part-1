import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/songs/song.dart';
import '../../dtos/song_dto.dart';
import 'song_repository.dart';

class SongRepositoryFirebase extends SongRepository {
  // Use your realtime DB base URL here
  final String baseUrl =
      'https://w9-database-d3690-default-rtdb.firebaseio.com';

  /// Fetch all songs
  @override
  Future<List<Song>> fetchSongs() async {
    final Uri songsUri = Uri.parse('$baseUrl/songs.json');

    final http.Response response = await http.get(songsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data =
          json.decode(response.body) as Map<String, dynamic>?;

      if (data == null) return [];

      return data.entries.map((entry) {
        final songId = entry.key;
        final songData = entry.value as Map<String, dynamic>;
        return SongDTO.fromMap(songData, songId);
      }).toList();
    } else {
      throw Exception('Failed to load songs from Firebase');
    }
  }

  /// Fetch a single song by ID
  @override
  Future<Song?> fetchSongById(String id) async {
    final Uri songUri = Uri.parse('$baseUrl/songs/$id.json');
    final http.Response response = await http.get(songUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? songJson =
          json.decode(response.body) as Map<String, dynamic>?;

      if (songJson == null) return null;

      return SongDTO.fromMap(songJson, id);
    } else {
      throw Exception('Failed to load song with id: $id');
    }
  }
}
