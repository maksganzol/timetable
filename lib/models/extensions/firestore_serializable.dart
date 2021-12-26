import 'package:cloud_firestore/cloud_firestore.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

extension FirestoreSerializable on QueryDocumentSnapshot<Map<String, dynamic>> {
  T toModel<T>(FromJson<T> fromJson) {
    final json = {'id': id, ...data()};
    return fromJson(json);
  }
}

extension FirestoreSerializableList
    on List<QueryDocumentSnapshot<Map<String, dynamic>>> {
  List<T> toModels<T>(FromJson<T> fromJson) {
    return map((doc) => doc.toModel(fromJson)).toList(growable: false);
  }
}
