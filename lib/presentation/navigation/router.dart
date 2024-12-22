import 'package:go_router/go_router.dart';
import 'package:satagro/presentation/home/home_page.dart';
import 'package:satagro/presentation/map/map_page.dart';
import 'package:satagro/presentation/navigation/route_path.dart';
import 'package:satagro/presentation/table/table_page.dart';

GoRouter router() {
  return GoRouter(
    routes: [
      home,
      map,
      table,
    ],
  );
}

final home = GoRoute(
  path: RoutePath.home,
  builder: (context, state) => HomePage(),
);

final map = GoRoute(
  path: RoutePath.map,
  builder: (context, state) => MapPage(),
);

final table = GoRoute(
  path: RoutePath.table,
  builder: (context, state) => TablePage(),
);
