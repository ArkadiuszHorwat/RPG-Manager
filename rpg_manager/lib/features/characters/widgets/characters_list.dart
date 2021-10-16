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

    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(10),
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      childAspectRatio: 0.8,
      children: generalCharacterList,
    );
  }
}
