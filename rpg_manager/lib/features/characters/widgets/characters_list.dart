import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rpg_manager/features/characters/characters_controller.dart';
import 'package:rpg_manager/features/characters/widgets/characters_list_item.dart';

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
        stream: controller.campaignsSnapshot,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          var charactersList = <Widget>[];
          charactersList =
              snapshot.data!.docs.map<Widget>((DocumentSnapshot document) {
            Map<dynamic, dynamic> data =
                document.data()! as Map<dynamic, dynamic>;

            return data["userId"] == userId
                ? CharacterListItem(
                    characterName: data['name'],
                    image: data['image'],
                  )
                : SizedBox.shrink();
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
