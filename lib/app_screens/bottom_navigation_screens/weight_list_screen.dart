import 'package:assignment/dialogs/dialog_edit_weight.dart';
import 'package:assignment/res/common_widgets/vertical_widget_spacer.dart';
import 'package:assignment/res/constantcolors.dart';
import 'package:assignment/res/flutterToast_message.dart';
import 'package:assignment/riverpod/future_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../res/strings.dart';

class WeightListScreen extends StatelessWidget {
  const WeightListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(builder: (_,WidgetRef ref,__){
          final sharedPref = ref.watch(sharedPreferencesProvider);
          var userID = sharedPref.value!.getString(Strings.userID);
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(userID).collection("items").orderBy('time', descending: true).snapshots(),
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
                      debugPrint("The weight is ${data['weight']}");
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
                          title: Text(data['weight'],style: const TextStyle(
                            color: Colors.black
                          ),),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: (){
                                  getCallEditWeight(context,data['weight'],userID,data['id']);
                                },
                                child: const Icon(Icons.edit,color: ConstantColors.secondaryColor),
                              ),
                              InkWell(
                                  onTap: (){
                                    getCallDeleteItem(data['id'],userID);
                                  },
                                  child: const Icon(Icons.delete,color: ConstantColors.secondaryColor,)),
                            ],
                          ),
                        )
                      );
                    }).toList(),
                  );
                }
            },
          );
        }),
      ),
    );
  }
  

  void getCallDeleteItem(String id, String? userID) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection('users').doc(userID).collection('items').doc(id);

    documentReference.delete().then((value){
      flutterToastMsg("Item Deleted");
    });
  }

  void getCallEditWeight(BuildContext context,String data, String? userID, String id) {
    showDialog(context: context, builder:
    (BuildContext context){
      return DialogEditWeight(weight: data);
    }).then((value) async {
      final document = FirebaseFirestore.instance
          .collection("users")
          .doc(userID)
          .collection("items")
          .doc(id);
      await document
          .update({
        'weight': value,
        'time': DateTime.now()
      })
          .then((value) {
        flutterToastMsg("Weight Updated");
      })
          .catchError((e) {
        flutterToastMsg(e.toString());
      });
    });
  }
}
