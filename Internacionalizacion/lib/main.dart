import 'package:flutter/material.dart';
import 'package:flutter_ejemplo_internacionalizacion/core/l10n/app_localizations.dart';
import 'package:flutter_ejemplo_internacionalizacion/features/preferences/presentation/pages/selected_language_page.dart';
import 'package:flutter_ejemplo_internacionalizacion/features/preferences/controllers/preferences_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ProviderScope(child: I18nApp()));
}

class I18nApp extends ConsumerWidget {
  const I18nApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocale = ref
        .watch(preferencesProvider)
        .when(
          data: (preferences) => preferences.language,
          loading: () => Locale('es'),
          error: (_, __) => Locale('es'),
        );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'i18n Study Buddy',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2255EE),
      ),
      locale: selectedLocale,
      supportedLocales: const [Locale('en'), Locale('es'), Locale('it')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SelectedLanguagePage(),
    );
  }
}
