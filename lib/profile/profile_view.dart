import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  final list = [
    ProfileDataModel(Icons.shopping_bag, 'My orders', null),
    ProfileDataModel(Icons.favorite, 'My Wishlist', null),
    ProfileDataModel(Icons.account_balance_wallet, 'My Card & Wallet', null),
    ProfileDataModel(Icons.location_on, 'My Addresses', null),
    ProfileDataModel(Icons.rate_review, 'My Reviews', null),
    ProfileDataModel(Icons.question_answer, 'My Questions & Answers', null),
    ProfileDataModel(Icons.logout, 'Logout', () async {
      await FirebaseAuth.instance.signOut();
      Get.back();
    }),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CircleAvatar(
              // backgroundImage: NetworkImage(''),
              radius: 40,
              child: Icon(
                Icons.account_circle_outlined,
                size: 60,
              ),
            ),
          ),
          Text(
            'Hello',
            style: Get.theme.textTheme.headline6,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                list.length,
                (index) {
                  return ListTile(
                    tileColor:
                        index % 2 == 0 ? Get.theme.primaryColor : Colors.white,
                    onTap: list[index].onTap,
                    leading: Icon(
                      list[index].icon,
                      color: Colors.black,
                    ),
                    title: Text(
                      list[index].title,
                      style: Get.theme.textTheme.subtitle1
                          .copyWith(color: Colors.black),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDataModel {
  IconData icon;
  String title;
  Function onTap;

  ProfileDataModel(this.icon, this.title, this.onTap);
}
