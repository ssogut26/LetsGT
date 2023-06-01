import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:letsgt/config/routes/routes.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/create_activity/domain/entities/network_entities.dart';
import 'package:letsgt/features/create_activity/domain/usecases/auto_complete_prediction.dart';
import 'package:letsgt/features/create_activity/domain/usecases/place_auto_complate_response.dart';
import 'package:letsgt/models/LocationModel.dart';

class SearchQuery extends ChangeNotifier {
  String _query = '';

  String get query => _query;

  set setQuery(String query) {
    _query = query;
  }
}

final searchQueryProvider = ChangeNotifierProvider(
  (ref) => SearchQuery(),
);

class LocationProvider extends ChangeNotifier {
  LatLng? _position;

  LatLng? get position => _position;

  set setPosition(LatLng position) {
    _position = position;
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final currentPosition = await Geolocator.getCurrentPosition();
    _position = LatLng(
      currentPosition.latitude,
      currentPosition.longitude,
    );
  }
}

final locationProvider = ChangeNotifierProvider(
  (ref) => LocationProvider(),
);

@RoutePage()
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  GoogleMapController? _controller;
  late Position _currentPosition;
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final geolocator = GeolocatorPlatform.instance;
    final currentLocation = await geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    _currentPosition = currentLocation;
    await _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude,
            _currentPosition.longitude,
          ),
          zoom: 14,
        ),
      ),
    );
  }

  bool isSearching = false;
  List<AutoCompletePrediction> placePredictions = [];
  final places = GoogleMapsPlaces(apiKey: dotenv.env['GOOGLE_MAPS_API_KEY']);
  Future<void> searchLocation(String params) async {
    final uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {
        'input': params,
        'key': dotenv.env['GOOGLE_MAPS_API_KEY'],
      },
    );
    final response = await NetworkEntities().searchByQuery(
      uri,
    );
    if (response?.isNotEmpty ?? false) {
      final result =
          PlaceAutoCompleteResponse.parseAutoCompleteResult(response ?? '');
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
  }

  PlacesDetailsResponse? details;
  String? address;
  LatLng? position = const LatLng(0, 0);

  Future<void> GetAddressFromLatLong(LatLng aposition) async {
    aposition = position ?? const LatLng(0, 0);
    if (position != null) {
      final placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position!.longitude,
      );

      final place = placemarks[0];
      final addressDetails = [
        place.street,
        place.thoroughfare,
        place.subThoroughfare,
        place.postalCode,
        place.subAdministrativeArea,
        place.administrativeArea,
      ];
      address = addressDetails.where((element) => element != null).join(', ');
    } else {
      address = null;
    }
  }

  Future<void> navigateTo(String place) async {
    details = await places.getDetailsByPlaceId(place);
    final lat = details?.result.geometry?.location.lat ?? 0;
    final lng = details?.result.geometry?.location.lng ?? 0;

    position = LatLng(lat, lng);

    await _controller
        ?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: position ?? const LatLng(0, 0),
              zoom: 14,
            ),
          ),
        )
        .whenComplete(
          () async =>
              await _controller?.showMarkerInfoWindow(const MarkerId('1')),
        );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = ref.watch(locationProvider);
    return Scaffold(
      appBar: AppBar(
        // search
        leading: IconButton(
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Select Location'),
      ),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.86,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation.position?.latitude ?? 39,
                  currentLocation.position?.longitude ?? 36,
                ),
                zoom: 14,
              ),
              myLocationEnabled: true,
              mapToolbarEnabled: true,
              indoorViewEnabled: true,
              cameraTargetBounds: CameraTargetBounds.unbounded,
              tiltGesturesEnabled: true,
              buildingsEnabled: true,
              myLocationButtonEnabled: true,
              onLongPress: (value) async {
                setState(() {
                  position = value;
                });
                await GetAddressFromLatLong(value);
                await _controller?.showMarkerInfoWindow(const MarkerId('2'));
              },
              markers: position == null
                  ? {}
                  : {
                      Marker(
                        markerId: const MarkerId('1'),
                        position: position ?? const LatLng(0, 0),
                        infoWindow: InfoWindow(
                          onTap: () {
                            AutoRouter.of(context).popAndPush(
                              CreateActivityRoute(
                                locationInfo: LocationModel(
                                  fullLocation: address ?? '',
                                  latitude: position?.latitude.toString() ?? '',
                                  longitude:
                                      position?.longitude.toString() ?? '',
                                ),
                              ),
                            );
                          },
                          title: address ?? details?.result.name ?? '',
                          snippet: 'Tap to set route',
                        ),
                      ),
                    },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPaddings.smallPadding,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search Location',
                      prefixIcon: Icon(Icons.search),
                    ),
                    focusNode: FocusNode(
                      skipTraversal: true,
                    ),
                    onChanged: (value) {
                      if (value.isEmpty || value == '') {
                        setState(() {
                          isSearching = false;
                        });
                      } else {
                        isSearching = true;
                      }
                      final prediction =
                          ref.read(searchQueryProvider).setQuery = value;
                      searchLocation(prediction);
                      // print(placePredictions.length);
                    },
                  ),
                ),
              ),
              SizedBox(
                height:
                    isSearching ? MediaQuery.of(context).size.height * 0.35 : 0,
                child: Card(
                  child: ListView.builder(
                    itemCount: placePredictions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        selectedTileColor: Colors.grey[300],
                        hoverColor: Colors.grey[300],
                        title: Text(placePredictions[index].description ?? ''),
                        onTap: () async {
                          ref.read(searchQueryProvider).setQuery = '';
                          setState(() {
                            isSearching = false;
                          });
                          FocusScope.of(context).unfocus();
                          await navigateTo(
                            placePredictions[index].placeId ?? '',
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
