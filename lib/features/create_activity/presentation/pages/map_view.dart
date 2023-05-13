import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:letsgt/core/usecases/paddings.dart';
import 'package:letsgt/features/create_activity/domain/entities/network_entities.dart';
import 'package:letsgt/features/create_activity/domain/usecases/auto_complete_prediction.dart';
import 'package:letsgt/features/create_activity/domain/usecases/place_auto_complate_response.dart';

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

@RoutePage()
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final controller = Completer<GoogleMapController>();
  final center = const LatLng(39.766705, 30.525631);
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
  LatLng? position;
  String? markerId;
  Future<void> navigateTo(String place) async {
    details = await places.getDetailsByPlaceId(place);
    final lat = details?.result.geometry?.location.lat ?? 0;
    final lng = details?.result.geometry?.location.lng ?? 0;

    position = LatLng(lat, lng);
    final controllerValue = await controller.future;
    await controllerValue
        .animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position!,
          zoom: 18,
        ),
      ),
    )
        .then((_) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      await controllerValue.showMarkerInfoWindow(const MarkerId('1'));
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: AppPaddings.pagePadding,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Location',
                  prefixIcon: Icon(Icons.search),
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
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height:
                  isSearching ? MediaQuery.of(context).size.height * 0.2 : 0,
              child: ListView.builder(
                itemCount: placePredictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(placePredictions[index].description ?? ''),
                    onTap: () async {
                      ref.read(searchQueryProvider).setQuery = '';
                      setState(() {
                        isSearching = false;
                      });
                      FocusScope.of(context).unfocus();
                      await navigateTo(placePredictions[index].placeId ?? '');
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: isSearching
                  ? MediaQuery.of(context).size.height * 0.6
                  : MediaQuery.of(context).size.height * 0.7,
              child: GoogleMap(
                onMapCreated: controller.complete,
                initialCameraPosition: CameraPosition(
                  target: center,
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
                  
                  // ADD MARKER
                  setState(() {
                    position = value;
                  });
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('1'),
                    position: position!,
                    onTap: () {
                      
                    },
                    infoWindow: InfoWindow(
                      title: details?.result.formattedAddress ?? '',
                      snippet: 'Location',
                    ),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
