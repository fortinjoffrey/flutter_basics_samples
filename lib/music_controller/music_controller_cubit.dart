import 'package:basics_samples/models/music.dart';
import 'package:basics_samples/music_controller/music_controller_state.dart';
import 'package:bloc/bloc.dart';

class MusicControllerCubit extends Cubit<MusicControllerState> {
  MusicControllerCubit() : super(MusicControllerState(music: null));

  void startMusic(Music musicData) {
    emit(MusicControllerState(music: musicData));
  }

  void stopMusic() {
    emit(MusicControllerState(music: null));
  }
}
