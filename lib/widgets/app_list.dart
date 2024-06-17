import 'package:flutter/material.dart';
import 'package:shelf/global_functions.dart';
import 'package:shelf/global_variables.dart';
import 'package:shelf/ui/theming.dart';
import 'package:shelf/utilities/shelf_utils.dart';
import 'package:shelf/widgets/Blinds.dart';



class AppListBuilder extends StatelessWidget {
  const AppListBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: allAppsListStream.stream, builder: (context, data) {
      if(data.hasData){return drawerLayout(data.data!);}
      if(allAppsList.isNotEmpty){return drawerLayout(allAppsList);}
      return const LoadingWidget();

    });
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: ShelfTheme.of(context).colors.primary,));
  }
}
