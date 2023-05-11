import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  List<AutoCompletePrediction> placePredictions = [];

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
        print(result.predictions!.length);
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search Location',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  searchLocation(ref.read(searchQueryProvider).query);
                },
                icon: const Icon(Icons.search),
              ),
            ),
            onChanged: (value) {
              searchLocation(value);
              // print(placePredictions.length);
              ref.read(searchQueryProvider).setQuery = value;
            },
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: placePredictions.length,
              itemBuilder: (context, index) {
                print(placePredictions.length);
                return Text(
                  placePredictions[index].description ?? '',
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: GoogleMap(
              onMapCreated: controller.complete,
              initialCameraPosition: CameraPosition(target: center),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
