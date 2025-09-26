import 'package:flutter/material.dart';
import 'package:flutter_application_catalog/catalog/widgets/showcase_scaffold.dart';
import 'package:flutter_application_catalog/core/widgets/app_button.dart';

class ButtonsDemo extends StatelessWidget {
  const ButtonsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseScaffold(
      title: 'Botones',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('AppButton – Primary'),
          const SizedBox(height: 8),
          AppButton(
            label: 'Confirmar',
            onPressed: () {},
            variant: AppButtonVariant.primary,
          ),

          const SizedBox(height: 16),
          const Text('AppButton – Secondary'),
          const SizedBox(height: 8),
          AppButton(
            label: 'Cancelar',
            onPressed: () {},
            variant: AppButtonVariant.secondary,
          ),
        ],
      ),
    );
  }
}
