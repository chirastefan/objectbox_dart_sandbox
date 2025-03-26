import 'package:objectbox/objectbox.dart';
import 'package:objectbox_dart_sandbox/models/team.dart';
import 'package:objectbox_dart_sandbox/models/user.dart';

@Entity()
class Player {
  @Id()
  int id;
  String name;

  // relationships
  final user = ToOne<User>();
  // @Backlink('players')
  final team = ToMany<Team>();

  Player({required this.name, this.id = 0});
}
