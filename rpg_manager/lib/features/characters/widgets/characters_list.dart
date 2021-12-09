import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';
import 'package:rpg_manager/features/characters/characters_controller.dart';
import 'package:rpg_manager/features/characters/widgets/characters_list_item.dart';
import 'package:rpg_manager/widgets/app_loading_screen.dart';

class CharacterList extends StatelessWidget {
  CharacterList({
    required this.controller,
    required this.userId,
  });

  final CharactersScreenController controller;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: controller.charactersSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return AppLoadingScreen(
              color: AppColors.appLight,
            );
          }
          var charactersList = <Widget>[];

          snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
            Map<dynamic, dynamic> data =
                document.data()! as Map<dynamic, dynamic>;
            if (data["userId"] == userId) {
              charactersList.add(CharacterListItem(
                characterName: data['name'],
                image: data['image'],
                controller: controller,
                characterId: document.id,
              ));
              return SizedBox.shrink();
            } else
              return SizedBox.shrink();
          }).toList();

          return Container(
            height: 300,
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(10),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.8,
              children: charactersList,
            ),
          );
        });
  }
}
