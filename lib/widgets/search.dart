import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/utilities/shelf_utils.dart';
import 'package:shelf/widgets/app_list.dart';
import 'package:shelf/widgets/Blinds.dart';



class SearchBuilder extends StatelessWidget {
  const SearchBuilder({
    super.key,
    required this.term,
  });

  final String term;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: allAppsListStream.stream, builder: (context, data) {
      if(allAppsList.isNotEmpty){
        final List<AppInfo> searchResults = [];
        for (AppInfo app in allAppsList) {
          if (app.name.toLowerCase().contains(term.toLowerCase())) {
            searchResults.add(app);
          }
        }
        return drawerLayout(searchResults);
      }
      return const LoadingWidget();

    });
  }
}
