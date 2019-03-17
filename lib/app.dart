import 'package:flavor_example/app.config.dart';
import 'package:flavor_example/build_mode.dart';
import 'package:flavor_example/fab.dart';
import 'package:flavor_example/util/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Flavor Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      floatingActionButton: Fab(),
      appBar: AppBar(
        title: const Text('Flutter Flavor Demo'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: const EdgeInsets.all(8),
            child: const Text('Flutter Info'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Table(
                columnWidths: {
                  0: const FlexColumnWidth(1),
                  1: const FlexColumnWidth(2)
                },
                border: TableBorder.all(),
                children: [
                  _buildRow(
                    label: 'Label',
                    value: 'Value',
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  _buildRow(label: 'buildMode', value: buildMode.toString()),
                  _buildRow(
                      label: 'flavor',
                      value: FlavorProvider.of(context).toString()),
                ],
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(8),
            child: const Text('PackageInfo'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final info = snap.data;
                  return Table(
                    columnWidths: {
                      0: const FlexColumnWidth(1),
                      1: const FlexColumnWidth(2)
                    },
                    border: TableBorder.all(),
                    children: [
                      _buildRow(
                        label: 'Label',
                        value: 'Value',
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      _buildRow(label: 'flavor', value: info.appName),
                      _buildRow(label: 'packageName', value: info.packageName),
                      _buildRow(label: 'version', value: info.version),
                      _buildRow(label: 'buildNumber', value: info.buildNumber),
                    ],
                  );
                },
              ),
            ),
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final info = snap.data;
              return AboutListTile(
                icon: const Icon(Icons.info),
                applicationName: info.appName,
                applicationIcon: const Icon(Icons.camera), // TODO:
                applicationVersion: info.version,
                applicationLegalese: 'desc',
                aboutBoxChildren: <Widget>[
                  Text('build: ${info.buildNumber}'),
                  Text('id: ${info.packageName}')
                ],
              );
            },
          ),
          RaisedButton(
            child: const Text('フィボナッチ(　´･‿･｀)'),
            onPressed: () async {
              final stopwatch = Stopwatch()..start();
//              await compute(_hoge, 3);
              await compute(_hoge, 40);
//              await _xxx('xxx');
              logger.info(stopwatch.elapsedMilliseconds);
            },
          ),
          RaisedButton(
            child: const Text('フィボナッチ(　´･‿･｀)'),
            onPressed: () async {
              final stopwatch = Stopwatch()..start();
//              await compute(_hoge, 3);
              _hoge(40);
//              await _xxx('xxx');
              logger.info(stopwatch.elapsedMilliseconds);
            },
          ),
        ],
      ),
    );
  }

  static String _hoge(int n) {
    final result = _fibonacci(n);
    logger.info('result: $result');
//    logger.info(foo);
    return 'bar';
  }

  static Future<String> _xxx(String foo) {
    return Future.value('bar');
  }

  TableRow _buildRow({
    @required String label,
    @required String value,
    TextStyle textStyle,
  }) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          label,
          style: textStyle,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(4),
        child: Text(
          value,
          style: textStyle,
        ),
      ),
    ]);
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InfoRow({
    Key key,
    @required this.label,
    @required this.value,
  }) : sufinper(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('$label: $value');
  }
}

int _fibonacci(int n) {
  return n < 2 ? n : (_fibonacci(n - 1) + _fibonacci(n - 2));
}
