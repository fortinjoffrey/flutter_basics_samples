import 'package:basics_samples/models/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'app user fromJson tests',
    () {
      final jsonData = {
        'uid': 'HLI7qkoocMuzWfv2lV94',
        'username': 'John Doe',
        'followings': ['id1', 'id2'],
        'followers': ['id3', 'id4'],
      };
      final expectedAppUser = AppUser(
        uid: 'HLI7qkoocMuzWfv2lV94',
        username: 'John Doe',
        followings: ['id1', 'id2'],
        followers: ['id3', 'id4'],
      );

      final sut = AppUser.fromJson(jsonData);

      expect(sut, expectedAppUser);
    },
  );
}
