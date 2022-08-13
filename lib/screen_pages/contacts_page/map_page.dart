import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:news/domain/providers/main_provider.dart';
import 'package:provider/provider.dart';


openMaps(BuildContext context) async {
  try {
    var data = context.read<MainProvider>();

    final coords = Coords(
      double.parse(data.listContacts[data.indexContact].address!.geo!.lat!),
      double.parse(data.listContacts[data.indexContact].address!.geo!.lng!),
    );
    final title = data.listContacts[data.indexContact].address!.city;
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
              children: <Widget>[
                for (var map in availableMaps)
                  ListTile(
                    onTap: () => map.showMarker(
                      coords: coords,
                      title: title!,
                    ),
                    title: Text(map.mapName),
                  ),
              ],
            ),
          ),
        );
      },
    );
  } catch (e) {
    debugPrint(e.toString());
  }
}