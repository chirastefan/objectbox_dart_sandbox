import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:objectbox_dart_sandbox/main.dart';
import 'package:objectbox_dart_sandbox/models/player.dart';
import 'package:objectbox_dart_sandbox/models/team.dart';
import 'package:objectbox_dart_sandbox/models/user.dart';
import 'package:objectbox_dart_sandbox/objectbox.dart';
import 'package:objectbox_dart_sandbox/routes.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

Widget Function(BuildContext, int) _itemBuilder(List<User> users) =>
    (BuildContext context, int index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: ListTile(
        textColor: Colors.white,
        tileColor: Colors.black87,
        dense: true,
        onTap: () => Get.toNamed(RoutesConsts.userDetails, arguments: users[index].id),
        title: Center(child: Text(users[index].name)),
      ),
    );

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: StreamBuilder<int>(
            stream: objectbox.getUsersCount(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Center(child: Text(snapshot.data.toString()));
              } else {
                return const Center(child: Text('0'));
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    final team = Team(name: 'team_${StringUtils.generateRandomString(10)}');
                    final teamPlayer1 = Player(name: 'team_player_${StringUtils.generateRandomString(10)}');
                    final teamPlayer2 = Player(name: 'team_player_${StringUtils.generateRandomString(10)}');

                    objectbox.setUser(
                      user:
                          User(name: 'user_${StringUtils.generateRandomString(10)}')
                            ..players.addAll([
                              Player(name: 'player_${StringUtils.generateRandomString(10)}'),
                              Player(name: 'player_${StringUtils.generateRandomString(10)}'),
                              Player(name: 'player_${StringUtils.generateRandomString(10)}'),
                            ])
                            ..teams.addAll([
                              team..players.addAll([teamPlayer1, teamPlayer2]),
                            ]),
                    );
                  },
                  child: const Text('Gen User'),
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () {
                    objectbox.setUsers();
                  },
                  child: const Text('Gen Users'),
                ),
              ),
              SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => objectbox.clearDB(),
                  child: const Text('Clear All'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: StreamBuilder<List<User>>(
            stream: objectbox.getUsers(),
            builder: (context, snapshot) {
              if (snapshot.data?.isNotEmpty ?? false) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                  itemBuilder: _itemBuilder(snapshot.data ?? []),
                );
              } else {
                return const Center(child: Text('No users'));
              }
            },
          ),
        ),
      ],
    );
  }
}
