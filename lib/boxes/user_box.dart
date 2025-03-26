part of '../objectbox.dart';

extension UserBox on ObjectBox {
  void clearAllUsers() => userBox.removeAllAsync();

  User getUser(int id) => userBox.get(id)!;

  Stream<int> getUsersCount() {
    final builder = userBox.query()..order(User_.name);
    return builder.watch(triggerImmediately: true).map((query) => query.count());
  }

  Stream<List<User>> getUsers() {
    final builder = userBox.query()..order(User_.name);
    return builder.watch(triggerImmediately: true).map((query) => query.find());
  }

  void setUser({required User user}) {
    userBox.putAsync(user);
  }

  void setUsers() {
    const count = 100000;
    final users = <User>[];

    for (int i = count; i <= count && i > 0; i--) {
      final user = User.new(name: StringUtils.generateRandomString(10));

      user.players.addAll([
        Player.new(name: StringUtils.generateRandomString(10)),
        Player.new(name: StringUtils.generateRandomString(10)),
        Player.new(name: StringUtils.generateRandomString(10))
      ]);
      users.add(user);
    }

    userBox.putManyAsync(users);
  }
}
