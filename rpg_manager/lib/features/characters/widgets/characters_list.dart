import 'package:flutter/cupertino.dart';
import 'package:rpg_manager/features/characters/widgets/characters_list_item.dart';

class CharacterList extends StatelessWidget {
  CharacterList({
    required this.data,
  });

  final List<String> data;

  @override
  Widget build(BuildContext context) {
    final generalCharacterList = <Widget>[];

    for (String player in data) {
      generalCharacterList.add(CharacterListItem(characterName: player));
    }

    return Column(
      children: generalCharacterList,
    );
  }
}
