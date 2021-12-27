import 'package:cloud_firestore/cloud_firestore.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

extension QueryDocumentSnapshotToModel
    on QueryDocumentSnapshot<Map<String, dynamic>> {
  T toModel<T>(FromJson<T> fromJson) {
    final json = {'id': id, ...data()};
    return fromJson(json);
  }
}

extension ListQueryDocumentSnapshotToModels
    on List<QueryDocumentSnapshot<Map<String, dynamic>>> {
  List<T> toModels<T>(FromJson<T> fromJson) {
    return map((doc) => doc.toModel(fromJson)).toList(growable: false);
  }
}

extension DocumentSnapshotToModel on DocumentSnapshot<Map<String, dynamic>> {
  T? toModel<T>(FromJson<T> fromJson) {
    final data = this.data();
    if (data == null) return null;
    final json = {'id': id, ...data};
    return fromJson(json);
  }
}
