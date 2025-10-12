import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kClaveModoOscuro = 'modoOscuro';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Leemos la preferencia antes de arrancar la app
  final preferencias = await SharedPreferences.getInstance();
  final modoOscuroGuardado = preferencias.getBool(kClaveModoOscuro) ?? false;

  runApp(Aplicacion(modoOscuroInicial: modoOscuroGuardado));
}

class Aplicacion extends StatefulWidget {
  final bool modoOscuroInicial;
  const Aplicacion({super.key, required this.modoOscuroInicial});

  @override
  State<Aplicacion> createState() => _EstadoAplicacion();
}

class _EstadoAplicacion extends State<Aplicacion> {
  late bool _modoOscuro;

  @override
  void initState() {
    super.initState();
    _modoOscuro = widget.modoOscuroInicial;
  }

  Future<void> _actualizarModoOscuro(bool valor) async {
    // Guardamos en shared_preferences
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setBool(kClaveModoOscuro, valor);

    // Actualizamos el tema en caliente
    setState(() => _modoOscuro = valor);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini App de Ajustes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _modoOscuro ? ThemeMode.dark : ThemeMode.light,
      home: PaginaAjustes(
        modoOscuro: _modoOscuro,
        onCambioModoOscuro: _actualizarModoOscuro,
      ),
    );
  }
}

class PaginaAjustes extends StatefulWidget {
  final bool modoOscuro;
  final ValueChanged<bool> onCambioModoOscuro;

  const PaginaAjustes({
    super.key,
    required this.modoOscuro,
    required this.onCambioModoOscuro,
  });

  @override
  State<PaginaAjustes> createState() => _EstadoPaginaAjustes();
}

class _EstadoPaginaAjustes extends State<PaginaAjustes> {
  late bool _modoOscuroLocal;

  @override
  void initState() {
    super.initState();
    _modoOscuroLocal = widget.modoOscuro;
  }

  Future<void> _alternarModoOscuro(bool valor) async {
    setState(() => _modoOscuroLocal = valor);
    widget.onCambioModoOscuro(valor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajustes')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Modo oscuro'),
            subtitle: const Text('Guarda la preferencia en el dispositivo'),
            value: _modoOscuroLocal,
            onChanged: _alternarModoOscuro,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Estado actual del tema'),
            subtitle: Text(_modoOscuroLocal ? 'Oscuro' : 'Claro'),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: FilledButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const PaginaDemostracion()),
              ),
              child: const Text('Ir a pantalla de demostración'),
            ),
          ),
        ],
      ),
    );
  }
}

class PaginaDemostracion extends StatelessWidget {
  const PaginaDemostracion({super.key});

  @override
  Widget build(BuildContext context) {
    final brillo = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(title: const Text('Demostración')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.palette, size: 64),
            const SizedBox(height: 12),
            Text(
              'Tema actual: ${brillo == Brightness.dark ? 'Oscuro' : 'Claro'}',
            ),
            const SizedBox(height: 8),
            const Text(
              'Cambia el interruptor en Ajustes y vuelve aquí.\n'
              'La preferencia persiste entre reinicios.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
