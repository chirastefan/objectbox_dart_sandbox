import 'dart:io';

import 'package:basic_utils/basic_utils.dart';
import 'package:objectbox_dart_sandbox/models/player.dart';
import 'package:objectbox_dart_sandbox/models/team.dart';
import 'package:objectbox_dart_sandbox/models/user.dart';
import 'package:objectbox_dart_sandbox/objectbox.g.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'boxes/players_box.dart';
part 'boxes/teams_box.dart';
part 'boxes/user_box.dart';

class ObjectBox {
  static const _dbName = 'obx_db';
  late final Store _store;
  late final Admin _admin;
  late final SyncClient _syncClient;
  late final Box<User> userBox;
  late final Box<Player> playersBox;
  late final Box<Team> teamsBox;

  ObjectBox._create(this._store) {
    if (Admin.isAvailable()) _admin = Admin(_store);

    if (Sync.isAvailable()) {
      _syncClient = Sync.client(_store, Platform.isAndroid ? 'ws://10.0.2.2:9999' : 'ws://127.0.0.1:9999', SyncCredentials.none());
      _syncClient.start();
    }

    userBox = Box<User>(_store);
    playersBox = Box<Player>(_store);
    teamsBox = Box<Team>(_store);
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    print(docsDir);
    final store = await openStore(
      directory: path.join(docsDir.path, _dbName),
      maxDBSizeInKB: 2 * 1024 * 1024, // 2GB
      macosApplicationGroup: 'obx_db.demo',
    );
    return ObjectBox._create(store);
  }

  Future<void> deleteDbFiles() async {
    final docDir = await getApplicationDocumentsDirectory();
    Directory('${docDir.path}/$_dbName').delete(recursive: true);
  }

  Future<void> clearDB() async {
    userBox.removeAllAsync();
    playersBox.removeAllAsync();
    teamsBox.removeAllAsync();
    await deleteDbFiles();
  }
}
