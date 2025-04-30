import 'package:e_commerce/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.white,
      padding: Constants.screenPadding,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top-aligned TextFormField
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Search anything...',
                      labelStyle: Constants.blue1BodyText,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.blue4, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Constants.blue3, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.search, size: 200,color: CupertinoColors.inactiveGray,),
              const Spacer(),
            ],
          ),

      ),
    );
  }
}
