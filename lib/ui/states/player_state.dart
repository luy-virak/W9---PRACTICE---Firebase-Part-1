import 'package:flutter/widgets.dart';

import '../../model/songs/song.dart';
import '../../model/artist/artist.dart';

class PlayerState extends ChangeNotifier {
  Song? _currentSong;
  Artist? _currentArtist;
  Artist? get currentArtist => _currentArtist;
  Song? get currentSong => _currentSong;

  void start(Song song, {Artist? artist}) {
    _currentArtist = artist;
    _currentSong = song;

    notifyListeners();
  }

  void stop() {
    _currentSong = null;
    _currentArtist = null;

    notifyListeners();
  }
}
