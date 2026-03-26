import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';
import '../../../../model/songs/song.dart';
import '../../../utils/async_value.dart';
import '../../../../data/repositories/Artist/artist_repository.dart';
import '../../../../model/artist/artist.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;

  final PlayerState playerState;

  AsyncValue<List<Song>> songsValue = AsyncValue.loading();
  AsyncValue<List<Artist>> artistsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.playerState,
    required this.artistRepository,
  }) {
    playerState.addListener(notifyListeners);

    // init
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    // 1- Loading state
    songsValue = AsyncValue.loading();
    artistsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // 2- Fetch songs and artists
      List<Song> songs = await songRepository.fetchSongs();
      List<Artist> artists = await artistRepository.fetchArtists();

      // 3- Update state with fetched data
      songsValue = AsyncValue.success(songs);
      artistsValue = AsyncValue.success(artists);
    } catch (e) {
      // 4- Handle errors
      songsValue = AsyncValue.error(e);
      artistsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song, {Artist? artist}) => playerState.start(song, artist: artist);
  void stop(Song song) => playerState.stop();
}
