part of '../../../../presentation/screens/feed_screen.dart';

class _FeedMap extends StatefulWidget {
  const _FeedMap();

  @override
  State<_FeedMap> createState() => _FeedMapState();
}

class _FeedMapState extends State<_FeedMap> with WidgetsBindingObserver {
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  static const LatLng _googlePlex = LatLng(37.4223, -122.0848);
  static const LatLng _applePark = LatLng(37.3346, -122.0090);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: _googlePlex,
    zoom: 13,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  BitmapDescriptor? _myPositionIconDescription;
  Uint8List? _myPositionIconBytes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<FeedMapBloc>().add(const InitEvent());

    getBytesFromAsset('assets/icons/my_position.png', 3, 96).then((value) {
      _myPositionIconBytes = value;
    });

  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // afficher un icone qui suit ma location
  // bouger la map pour suivre ma location

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        context.read<FeedMapBloc>().add(const FeedAppResumedEvent());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedMapBloc, FeedMapState>(
        builder: (context, state) {
          return Column(
            children: [
              BlocBuilder<FeedMapBloc, FeedMapState>(
                builder: (context, state) {
                  return Text(state.permissionStatus.toString());
                },
              ),
              Expanded(
                child: BlocListener<FeedMapBloc, FeedMapState>(
                  listener: (context, state) async {
                    if (state.mode is! CenterOnUserLocationMapMode) return;

                    final userLocation = state.userLocation;

                    if (userLocation != null) {
                      final controller = await _mapController.future;
                      controller.animateCamera(CameraUpdate.newLatLng(userLocation));
                    }
                  },
                  child: BlocBuilder<FeedMapBloc, FeedMapState>(
                    builder: (context, state) {
                      final userLocation = state.userLocation;

                      return Stack(
                        children: [
                          GoogleMap(
                            markers: {
                              if (userLocation != null && _myPositionIconBytes != null)
                                Marker(
                                  markerId: const MarkerId('my_location'),
                                  position: userLocation,
                                  anchor:const Offset(0.5, 0.5) ,
                                  icon: BitmapDescriptor.fromBytes(_myPositionIconBytes!),
                                  infoWindow: const InfoWindow(title: 'Google'),
                                ),
                              const Marker(
                                markerId: MarkerId('1'),
                                position: _googlePlex,
                                icon: BitmapDescriptor.defaultMarker,
                                infoWindow: InfoWindow(title: 'Google'),
                              ),
                              const Marker(
                                markerId: MarkerId('2'),
                                position: _applePark,
                                infoWindow: InfoWindow(title: 'Apple'),
                              ),
                            },
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: true,
                            myLocationButtonEnabled: false,
                            compassEnabled: true,
                            buildingsEnabled: false,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _mapController.complete(controller);
                            },
                            onCameraMove: (position) {
                              // TODO: (JFO) reset to free mode if lock on me mode
                            },
                          ),
                          Positioned(
                            right: 16,
                            bottom: 100,
                            child: IconButton(
                              onPressed: () {
                                context.read<FeedMapBloc>().add(const LockOnMeEvent());
                              },
                              icon: Icon(Icons.my_location),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 130,
                            child: IconButton(
                              onPressed: () {
                                context.read<FeedMapBloc>().add(const FreeModeEvent());
                              },
                              icon: Icon(Icons.wifi_calling),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<FeedMapBloc>().add(const SwitchMapModeEvent(CenterOnEiffelTowerMapMode()));
        },
        // onPressed: _goToTheLake,
        child: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

Future<Uint8List?> getBytesFromAsset(String path, double devicePixelRatio, int width) async {
  ByteData data = await rootBundle.load(path);
  Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: (devicePixelRatio * width).round());
  FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ImageByteFormat.png))?.buffer.asUint8List();
}
