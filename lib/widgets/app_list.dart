import 'package:flutter/material.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/widgets/blinders.dart';



class AppListBuilder extends StatelessWidget {
  const AppListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: allAppsListStream.stream, builder: (context, data) {
      if(data.hasData){return appsLayout(data.data!);}
      if(allAppsList.isNotEmpty){return appsLayout(allAppsList);}
      return const Center(child: CircularProgressIndicator());

    });
  }
}
