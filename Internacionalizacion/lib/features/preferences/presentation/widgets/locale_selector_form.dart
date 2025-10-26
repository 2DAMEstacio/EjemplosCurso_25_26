import 'package:flutter/material.dart';

class LocaleSelectorForm extends StatelessWidget {
  final Locale? currentLocale;
  const LocaleSelectorForm({super.key, this.currentLocale});

  @override
  Widget build(BuildContext context) {
    final options = const [Locale('es'), Locale('en'), Locale('it')];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Selecciona idioma',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...options.map((selLocale) {
            final title = switch (selLocale.languageCode) {
              'es' => 'Español',
              'en' => 'English',
              'it' => 'Italiano',
              _ => selLocale.toLanguageTag(),
            };
            final selected =
                currentLocale?.languageCode == selLocale.languageCode;
            return ListTile(
              title: Text(title),
              trailing: selected ? Icon(Icons.check) : null,
              selected: selected,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () => Navigator.pop(context, selLocale),
            );
          }),
        ],
      ),
    );
  }
}
