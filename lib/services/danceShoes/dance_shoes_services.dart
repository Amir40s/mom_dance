import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mom_dance/constant.dart';
import 'package:mom_dance/db_key.dart';
import 'package:mom_dance/model/compJournal/comp_journal_model.dart';
import 'package:mom_dance/model/danceShoes/dance_shoes_model.dart';
import 'package:mom_dance/model/dancer/dancer_model.dart';
import 'package:mom_dance/provider/constant/value_provider.dart';
import 'package:mom_dance/provider/image/image_provider.dart';
import 'package:provider/provider.dart';

class DanceShoesServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addDanceShoes(DanceShoesModel compJournal,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID)
        .collection(DbKey.c_danceShoes)
        .doc(compJournal.id)
        .set(compJournal.toMap())
        .whenComplete((){
      showSnackBar(title: "Details Updated", subtitle: "");
     // Provider.of<ImagePickProvider>(context,listen: false).clear();
       Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> updateDanceShoes(DanceShoesModel compJournal,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(compJournal.dancerId)
        .collection(DbKey.c_danceShoes)
        .doc(compJournal.id)
        .update(compJournal.toMap())
        .whenComplete((){
      showSnackBar(title: "Details Updated", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
      Navigator.pop(context);
    });
  }

  Future<void> deleteDanceShoes(String shoesID,BuildContext context,String dancerID) async {
    await _db
        .collection(DbKey.c_dancers)
        .doc(dancerID)
        .collection(DbKey.c_danceShoes)
        .doc(shoesID)
        .delete()
        .whenComplete((){
      showSnackBar(title: "Shoes deleted", subtitle: "");
      // Provider.of<ImagePickProvider>(context,listen: false).clear();
      Provider.of<ValueProvider>(context,listen: false).setLoading(false);
    });
  }
}
