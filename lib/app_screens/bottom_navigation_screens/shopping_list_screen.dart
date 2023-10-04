import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/strings.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (_,WidgetRef ref,__){
        final sharedPref = ref.watch(sharedPreferencesProvider);
        var userID = sharedPref.value!.getString(Strings.userID);
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("users").doc(userID).collection("items").snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState== ConnectionState.waiting)
              {
                return const Center(
                  child: CircularProgressIndicator(
                    color: ConstantColors.secondaryColor,
                  ),
                );
              }else if(snapshot.hasError)
              {
                return Center(
                  child: Text('Error: ${snapshot.error}',style: const TextStyle(
                      color: ConstantColors.secondaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                  ),),
                );
              }
              else{
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    // Use data in your UI, for example:
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ConstantColors.borderLineColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: ListTile(
                        title: Text(data['item_name']),
                        trailing: InkWell(
                            onTap: (){

                            },
                            child: const Icon(Icons.chevron_right,color: ConstantColors.secondaryColor,)),
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        );
      }),
    );
  }
}
