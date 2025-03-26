import 'package:objectbox/objectbox.dart';
import 'package:objectbox_dart_sandbox/models/player.dart';
import 'package:objectbox_dart_sandbox/models/team.dart';

@Entity()
class User {
  @Id()
  int id;
  String name;

  // relationships
  @Backlink('user')
  final players = ToMany<Player>();
  @Backlink('user')
  final teams = ToMany<Team>();

  User({required this.name, this.id = 0});
}
