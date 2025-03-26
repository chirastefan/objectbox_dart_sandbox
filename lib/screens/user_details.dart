import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:objectbox_dart_sandbox/main.dart';
import 'package:objectbox_dart_sandbox/models/player.dart';
import 'package:objectbox_dart_sandbox/models/team.dart';
import 'package:objectbox_dart_sandbox/objectbox.dart';
import 'package:objectbox_dart_sandbox/widgets/dialogs/players_dialog.dart';

class UserDetails extends StatefulWidget {
  final int userId;

  const UserDetails({super.key, required this.userId});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Column(
          children: [
            SizedBox(height: 40, child: Text('Players', style: Get.context?.textTheme.titleLarge)),
            Expanded(
              child: StreamBuilder<List<Player>>(
                stream: objectbox.getPlayers(userId: widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.data?.isNotEmpty ?? false) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            child: ListTile(
                              textColor: Colors.white,
                              tileColor: Colors.black87,
                              dense: true,
                              title: Text(snapshot.data?[index].name ?? ''),
                            ),
                          ),
                    );
                  } else {
                    return const Center(child: Text('No players'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            SizedBox(height: 40, child: Text('Teams', style: Get.context?.textTheme.titleLarge)),
            Expanded(
              child: StreamBuilder<List<Team>>(
                stream: objectbox.getTeams(userId: widget.userId),
                builder: (context, snapshot) {
                  if (snapshot.data?.isNotEmpty ?? false) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.hasData ? snapshot.data!.length : 0,
                      itemBuilder:
                          (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                            child: ListTile(
                              trailing: Icon(Icons.remove_red_eye, color: Colors.white),
                              textColor: Colors.white,
                              tileColor: Colors.black87,
                              dense: true,
                              title: Text(snapshot.data?[index].name ?? ''),
                              onTap: () async {
                                final teamId = snapshot.data?[index].id;
                                if (teamId == null) return;

                                await Get.dialog(PlayersDialog(userId: widget.userId, teamId: teamId));
                              },
                            ),
                          ),
                    );
                  } else {
                    return const Center(child: Text('No teams'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
