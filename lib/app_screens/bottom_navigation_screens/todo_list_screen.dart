import 'package:assignment/dialogs/dialog_add_shopping.dart';
import 'package:assignment/res/common_widgets/vertical_widget_spacer.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/flutterToast_message.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../res/strings.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(builder: (_,WidgetRef ref,__){
          final sharedPref = ref.watch(sharedPreferencesProvider);
          var userID = sharedPref.value!.getString(Strings.userID);
          return StreamBuilder(
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
                    //shrinkWrap: true,
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
                              getCallDeleteItem(data['id'],userID);
                            },
                              child: const Icon(Icons.delete,color: ConstantColors.secondaryColor,)),
                        ),
                      );
                    }).toList(),
                  );
                }
            },
          );
        }),
      ),
      floatingActionButton:
      Consumer(builder: (_,WidgetRef ref,__){
        return FloatingActionButton(onPressed: (){
          getCallShoppingListItems(context, ref);
        },
          backgroundColor: ConstantColors.secondaryColor,
          child: const Icon(Icons.add,color: Colors.white,),
        );
      })
    );
  }

  void getCallShoppingListItems(BuildContext context, WidgetRef ref) {
    final sharedPref = ref.watch(sharedPreferencesProvider);
    var userID = sharedPref.value!.getString(Strings.userID);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DialogAddShopping();
        }).then((item) async {
      if (item != null) {
        final document = FirebaseFirestore.instance
            .collection("users")
            .doc(userID)
            .collection("items")
            .doc();
        await document
            .set({
              'id': document.id,
              'item_name': item,
            })
            .then((value) {})
            .catchError((e) {
              flutterToastMsg(e.toString());
            });
      }
    });
  }

  void getCallDeleteItem(String id, String? userID) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('users').doc(userID).collection('items').doc(id);

    documentReference.delete().then((value){
      flutterToastMsg("Item Deleted");
    });
  }
}
