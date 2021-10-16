import 'package:flutter/cupertino.dart';
import 'package:rpg_manager/features/players/widgets/players_list_item.dart';

class PlayersList extends StatelessWidget {
  PlayersList({
    required this.data,
  });

  final List<String> data;

  @override
  Widget build(BuildContext context) {
    final generalPlayersList = <Widget>[];

    for (String player in data) {
      generalPlayersList.add(PlayersListItem(playerName: player));
    }

    return Column(
      children: generalPlayersList,
    );
  }
}
