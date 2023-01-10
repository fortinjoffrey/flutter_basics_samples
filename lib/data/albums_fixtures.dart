import 'package:basics_samples/models/album.dart';
import 'package:basics_samples/models/music.dart';

class AlbumFixtures {
  static List<Album> get albums => [
        Album(
          musics: [
            Music(title: 'Proident anim proident'),
          ],
          title: 'Ullamco cillum',
        ),
        Album(
          musics: [
            Music(title: 'Dolore ea laboris'),
            Music(title: 'Anim est qui ipsum'),
          ],
          title: 'Nulla exercitation',
        ),
        Album(
          musics: [
            Music(title: 'Incididunt est voluptate'),
            Music(title: 'Laborum enim exercitation aute'),
            Music(title: 'Labore voluptate velit'),
          ],
          title: 'Nostrud ea ut',
        ),
      ];
}
