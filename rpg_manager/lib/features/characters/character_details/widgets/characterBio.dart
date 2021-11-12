import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rpg_manager/app_assets/colors/colors.dart';

class CharacterBio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.appLight,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadiusDirectional.all(Radius.circular(20)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Biografia',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec suscipit erat vel pretium mollis.'
                    'Donec nec neque non quam ultrices imperdiet ac vel arcu. Aenean magna justo, efficitur porta volutpat at,'
                    'consequat eu lorem. Vivamus mattis elementum urna, in ullamcorper urna eleifend eget. Praesent sagittis sagittis neque,'
                    'a egestas enim finibus non. Phasellus nisi leo, ullamcorper ut tempor vitae, mattis venenatis arcu. Nam eget justo sodales,'
                    'sollicitudin metus eu, suscipit odio. Morbi tempus faucibus augue, eget tristique leo porttitor vel. Vestibulum condimentum'
                    'velit vitae ipsum laoreet lobortis. Sed tempor felis quis interdum aliquam.'
                    'Integer metus felis, vestibulum ac cursus a, rutrum quis nisl. Nullam congue, massa a ultricies aliquet,'
                    'metus nunc tincidunt mauris, vel convallis sapien lacus quis diam.',
                    style: GoogleFonts.rubik(
                      textStyle: TextStyle(
                        color: AppColors.appDark,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    color: AppColors.appDark,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
