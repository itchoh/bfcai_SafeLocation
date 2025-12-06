
import 'package:firebase_auth/firebase_auth.dart';

import '../model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
abstract class FirebaseDatabase{
  static CollectionReference<UserModel> collectionUser(){
    return FirebaseFirestore.instance
        .collection("Users")
        .withConverter<UserModel>(
  fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
  toFirestore:(user, _) => user.toJson(),
  );
}
  static Future<void> createUser(UserModel user)async{
    return collectionUser().doc(user.id).set(user);
  }
  static Future<UserModel?> getUser(String userId)async{
    var data = await collectionUser().doc(userId).get();
    return data.data();
  }
  /*static CollectionReference<TaskModel> collectionTasks(){
    String userId=FirebaseAuth.instance.currentUser?.uid??"";
    return colleectionUser().doc(userId).collection("Tasks").withConverter<TaskModel>(
      fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!,snapshot.id),
      toFirestore: (task, _) => task. toJson(),
    );

    }
    static Future<void>addTask({required String title,required String description,required  int periority,required DateTime date})async{
      var docRef= collectionTasks().doc();
      var userId=docRef.id;
      TaskModel userTask= TaskModel(
        data: date,
        priority: periority,
        description: description,
        title: title,
        id: userId
      );
      docRef.set(userTask);
    }
    static getAllTasks()async{
       try {
         var dataListOfTasks= await collectionTasks().get();

         return dataListOfTasks.docs.map((task)=>task.data()).toList();
       } on Exception catch (e) {
         throw("Error loading tasks: $e");
         return [];
       }

    }
    static Future<void> updateTask(TaskModel task)async{
      return await collectionTasks().doc(task.id).update(task.toJson());
    }
  static Future<void>deleteTask(TaskModel task)async{
      return await collectionTasks().doc(task.id).delete();
    }*/
  }