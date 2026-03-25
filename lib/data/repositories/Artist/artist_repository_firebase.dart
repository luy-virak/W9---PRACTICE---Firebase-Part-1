import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../model/artist/artist.dart';
import '../../dtos/artist_dto.dart';
import 'artist_repository.dart';

class ArtistRepositoryFirebase extends ArtistRepository {
  // Use your realtime DB base URL here
  final String baseUrl =
      'https://w9-database-d3690-default-rtdb.firebaseio.com';

  /// Fetch all artists
  @override
  Future<List<Artist>> fetchArtists() async {
    final Uri artistsUri = Uri.parse('$baseUrl/artists.json');

    final http.Response response = await http.get(artistsUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data =
          json.decode(response.body) as Map<String, dynamic>?;

      if (data == null) return [];

      return data.entries.map((entry) {
        final artistId = entry.key;
        final artistData = entry.value as Map<String, dynamic>;
        return ArtistDTO.fromMap(artistData, artistId);
      }).toList();
    } else {
      throw Exception('Failed to load artists from Firebase');
    }
  }

  /// Fetch a single artist by ID
  @override
  Future<Artist?> fetchArtistById(String id) async {
    final Uri artistUri = Uri.parse('$baseUrl/artists/$id.json');
    final http.Response response = await http.get(artistUri);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? artistJson =
          json.decode(response.body) as Map<String, dynamic>?;

      if (artistJson == null) return null;

      return ArtistDTO.fromMap(artistJson, id);
    } else {
      throw Exception('Failed to load artist with id: $id');
    }
  }
}
