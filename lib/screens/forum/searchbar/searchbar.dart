import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:project_polymer/shared/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbar extends StatefulWidget {
  @override
  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  Widget searchbar = Text('Search',
      style:
          GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: whiteOpacity));

  Widget icon = Icon(
    Icons.search,
    size: 18,
    color: whiteOpacity,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          height: 55,
          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
          decoration: BoxDecoration(
            color: elementColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              searchbar,
              icon,
            ],
          ),
        ),
        onTap: () {
          setState(() {
            searchbar = Flexible(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                    decoration: searchbarDecoration.copyWith(hintText: 'Search'),
                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: whiteOpacity),
                  ),
              ),
            );
            icon = Icon(
              MdiIcons.arrowRight,
              size: 18,
              color: whiteOpacity,
            );
          });
        },
        onTapCancel: () {
          setState(() {
            searchbar = Text('Search',
      style:
          GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: whiteOpacity));
            icon = Icon(
              Icons.search,
              size: 18,
              color: whiteOpacity,
            );
          });
        }
        );
  }
}
