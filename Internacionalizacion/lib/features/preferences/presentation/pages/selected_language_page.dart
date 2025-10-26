import 'package:flutter/material.dart';
import 'package:flutter_ejemplo_internacionalizacion/core/l10n/app_localizations.dart';
import 'package:flutter_ejemplo_internacionalizacion/features/preferences/controllers/preferences_controller.dart';
import 'package:flutter_ejemplo_internacionalizacion/features/preferences/presentation/widgets/locale_selector_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedLanguagePage extends ConsumerStatefulWidget {
  const SelectedLanguagePage({super.key});

  @override
  ConsumerState<SelectedLanguagePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<SelectedLanguagePage> {
  int _count = 1;
  String _gender = 'male';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final message =
        "${l10n.hello("Flutter")}\n${l10n.applesCount(_count)}\n${l10n.userGender(_gender)}";

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _showLanguagePicker(context),
          ),
        ],
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.concept_plural),
                    const SizedBox(width: 12),
                    DropdownMenu<int>(
                      initialSelection: 1,
                      onSelected: (value) =>
                          setState(() => _count = value ?? 0),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 1, label: '1'),
                        DropdownMenuEntry(value: 2, label: '2'),
                        DropdownMenuEntry(value: 3, label: '3'),
                        DropdownMenuEntry(value: 3, label: '4'),
                        DropdownMenuEntry(value: 3, label: '5'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.concept_select),
                    const SizedBox(width: 12),
                    DropdownMenu<String>(
                      initialSelection: 'male',
                      onSelected: (String? value) {
                        setState(() {
                          setState(() => _gender = value ?? 'male');
                        });
                      },
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: 'male', label: '♂️'),
                        DropdownMenuEntry(value: 'female', label: '♀️'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLanguagePicker(BuildContext context) async {
    final preferencesController = ref.read(preferencesProvider.notifier);
    // Locale selectedLocale = ref.read(preferencesProvider).value!.language;

    final selectedLocale = ref
        .watch(preferencesProvider)
        .when(
          data: (preferences) => preferences.language,
          loading: () => Locale('es'),
          error: (_, __) => Locale('es'),
        );

    final selected = await showModalBottomSheet<Locale?>(
      context: context,
      builder: (_) {
        return LocaleSelectorForm(currentLocale: selectedLocale);
      },
    );
    if (mounted && selected != null) {
      await preferencesController.setLocale(selected);
    }
  }
}
