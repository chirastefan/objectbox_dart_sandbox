part of '../objectbox.dart';

extension TeamsBox on ObjectBox {
  Stream<List<Team>> getTeams({required int userId}) {
    final builder = teamsBox.query()..order(Team_.id, flags: Order.descending);
    builder.link(Team_.user, User_.id.equals(userId));
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }
}
