import 'package:flutter/material.dart';
import 'package:flutter_assingment_2/screens/home/home_controller.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (HomeController controller) => Scaffold(
              appBar: AppBar(
                toolbarHeight: 60,
                leading: Image.asset("assets/logo.png"),
                backgroundColor: Colors.brown.shade900,
              ),
              body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepOrange, Colors.indigo.shade900])),
                child: ListView(
                  children: [
                    Center(
                      heightFactor: 2,
                      child: Text("Browse Your Favorite Movies",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: Colors.white54, thickness: 0.5),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 20,
                          spacing: 10,
                          children: controller.movieCards,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _btn(Colors.deepOrange, "Goto Previous Page",
                            controller.prevPage),
                        _btn(Colors.green, "Goto Next Page",
                            controller.nextPage),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  Widget _btn(Color btnColor, String btnText, Function controller) {
    return Container(
      width: Get.width * 0.5,
      child: RaisedButton(
        onPressed: () {
          controller();
        },
        color: btnColor,
        child: Text(btnText,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
