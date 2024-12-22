import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooked_bloc/hooked_bloc.dart';
import 'package:satagro/presentation/style/dimensions.dart';
import 'package:satagro/presentation/widgets/app_button.dart';
import 'package:satagro/presentation/map/cubit/map_page_cubit.dart';

class MapPage extends HookWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = useBloc<MapPageCubit>();
    final state = useBlocBuilder(cubit);

    const dafaultTarget = LatLng(90, 0);
    const defaultPosition = 16.0;

    useEffect(
      () {
        cubit.init();
        return null;
      },
      [cubit],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text('Cel 1'),
        centerTitle: true,
      ),
      body: switch (state) {
        MapPageIdle(
          :final markers,
          :final polygons,
          :final position,
          :final isCreatingPolygonMode,
        ) =>
          Stack(
            children: [
              GoogleMap(
                onTap: cubit.drawPolygon,
                markers: markers,
                polygons: polygons,
                compassEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: position ?? dafaultTarget,
                  zoom: position != null ? defaultPosition : 0,
                ),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
              if (isCreatingPolygonMode)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    Dimensions.v8,
                    Dimensions.v56,
                    Dimensions.v8,
                    Dimensions.v0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        onTap: cubit.deleteLastPoint,
                        title: 'Usuń ostatnio dodany punkt ',
                      ),
                      AppButton(
                        onTap: cubit.submitPolygon,
                        title: 'Zatwierdź',
                      ),
                    ],
                  ),
                )
            ],
          ),
        MapPageLoading() => Center(
            child: CircularProgressIndicator(),
          ),
      },
    );
  }
}
