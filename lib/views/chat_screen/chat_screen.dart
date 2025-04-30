import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.white,
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: Constants.white,
                child: ListView(
                  children: [
                    Container(
                      color: Constants.blue5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      ),
                      child: Column(
                        children: [
                          Text("Message here...",style: Constants.blue1SmallBodyText,),
                          SizedBox(height: 5,),
                          Text("11:45pm",style: Constants.blackSmallBodyText,)
                        ],
                      ),
                    )
                  ],
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Type a meassage...",
                        hintStyle: Constants.blue1BodyText,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Constants.blue1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Constants.blue1
                          ),
                        ),
                      ),
                    )),
                IconButton(
                    onPressed: (){
                      Get.to(()=>ChatScreen());
                    },
                    icon: Icon(Icons.send,color: Constants.blue1,)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
