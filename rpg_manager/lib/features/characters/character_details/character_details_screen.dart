import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rpg_manager/features/characters/character_details/character_details_controller.dart';
import 'package:rpg_manager/widgets/app_background.dart';
import 'package:rpg_manager/widgets/app_nav_bar.dart';

class CharacterDetailsScreen extends StatelessWidget {
  CharacterDetailsScreen({
    Key? key,
    required this.characterId,
  }) : super(key: key);

  final String characterId;

  final _controller = CharacterDetailsScreenController();

  @override
  Widget build(BuildContext context) {
    final _characterDetails =
        _controller.getCharacterDetails(characterId: characterId);

    return AppBackground(
      child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: _characterDetails.get(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;

              final String? image = data['image'];

              return Scaffold(
                appBar: AppNavBar(
                  title: '${data['name']}',
                ),
                backgroundColor: Colors.transparent,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                        child: Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                            ],
                            borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(20)),
                            image: image == null || !File(image).existsSync()
                                ? DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.6),
                                        BlendMode.dstATop),
                                    image: AssetImage(
                                      'lib/app_assets/images/character-img.jpg',
                                    ),
                                  )
                                : DecorationImage(
                                    fit: BoxFit.cover,
                                    colorFilter: new ColorFilter.mode(
                                        Colors.black.withOpacity(0.5),
                                        BlendMode.dstATop),
                                    image: FileImage(File(image)),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          }),
    );
  }
}
