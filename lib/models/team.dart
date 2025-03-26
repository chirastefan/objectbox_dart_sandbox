import 'package:objectbox/objectbox.dart';
import 'package:objectbox_dart_sandbox/models/player.dart';
import 'package:objectbox_dart_sandbox/models/user.dart';

@Entity()
class Team {
  @Id()
  int id;
  String name;

  // relationships
  final user = ToOne<User>();
  @Backlink('team')
  final players = ToMany<Player>();

  Team({required this.name, this.id = 0});
}
