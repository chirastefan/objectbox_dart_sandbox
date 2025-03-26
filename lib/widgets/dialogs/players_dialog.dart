import 'package:flutter/material.dart';
import 'package:objectbox_dart_sandbox/main.dart';
import 'package:objectbox_dart_sandbox/models/player.dart';
import 'package:objectbox_dart_sandbox/objectbox.dart';

class PlayersDialog extends StatelessWidget {
  final int userId;
  final int teamId;

  const PlayersDialog({super.key, required this.userId, required this.teamId});

  @override
  Widget build(BuildContext context) => AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
    actionsAlignment: MainAxisAlignment.spaceAround,
    title: const Center(child: Text('Players')),
    content: Container(
      constraints: const BoxConstraints(minWidth: 320),
      child: StreamBuilder<List<Player>>(
        stream: objectbox.getPlayers(userId: userId, teamId: teamId),
        builder: (context, snapshot) {
          if (snapshot.data?.isNotEmpty ?? false) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: (context, index) {
                return Text(snapshot.data?[index].name ?? '');
              },
            );
          } else {
            return const Center(child: Text('No players'));
          }
        },
      ),
    ),
  );
}
