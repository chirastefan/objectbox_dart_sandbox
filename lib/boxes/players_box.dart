part of '../objectbox.dart';

extension PlayersBox on ObjectBox {
  Stream<List<Player>> getPlayers({required int userId, int? teamId}) {
    final builder = playersBox.query()..order(Player_.id, flags: Order.descending);
    builder.link(Player_.user, User_.id.equals(userId));

    if (teamId != null) builder.linkMany(Player_.team, Team_.id.equals(teamId));

    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
