import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:satagro/presentation/widgets/app_button.dart';
import 'package:satagro/presentation/navigation/route_path.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppButton(
              onTap: () => context.push(RoutePath.map),
              title: 'Cel 1',
            ),
            const SizedBox(height: 20),
            AppButton(
              onTap: () => context.push(RoutePath.table),
              title: 'Cel 2',
            ),
          ],
        ),
      ),
    );
  }
}
