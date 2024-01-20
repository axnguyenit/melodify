import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain.dart';

typedef QueryDocSnapshot = QueryDocumentSnapshot<Map<String, dynamic>>;

class OrderBy {
  final String field;
  final bool descending;

  OrderBy({
    required this.field,
    this.descending = false,
  });
}

abstract class BaseFirestoreService<T extends Model> {
  final Mapper<T> _mapper;
  final CollectionReference<Map<String, dynamic>> collectionRef;

  BaseFirestoreService({
    required Mapper<T> mapper,
    required this.collectionRef,
  }) : _mapper = mapper;

  Future<T> createDocument(Map<String, dynamic> data) async {
    final docRef = await collectionRef.add(data);
    return (await getDocument(docRef.id))!;
  }

  Future<T?> getDocument(String id) async {
    final docSnapshot = await collectionRef.doc(id).get();
    if (!docSnapshot.exists) return null;
    final json = docSnapshot.data()!;
    json['id'] = docSnapshot.id;

    return _mapper.parser(json);
  }

  Future<List<T>> getList({
    List<OrderBy> ordersBy = const [],
  }) async {
    Query<Map<String, dynamic>> query = collectionRef;
    if (ordersBy.isNotEmpty) {
      for (final orderBy in ordersBy) {
        query = query.orderBy(orderBy.field, descending: orderBy.descending);
      }
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) {
      final json = doc.data();
      json['id'] = doc.id;

      return _mapper.parser(json);
    }).toList();
  }

  Future<List<T>> getListPaging({
    int limit = 20,
    List<OrderBy> ordersBy = const [],
    QueryDocSnapshot? lastDocument,
  }) async {
    Query<Map<String, dynamic>> query;
    if (lastDocument == null) {
      query = collectionRef.limit(limit);
    } else {
      query = collectionRef.startAfterDocument(lastDocument).limit(limit);
    }
    if (ordersBy.isNotEmpty) {
      for (final orderBy in ordersBy) {
        query = query.orderBy(orderBy.field, descending: orderBy.descending);
      }
    }

    final querySnapshot = await query.get();
    lastDocument = querySnapshot.docs.last;

    return querySnapshot.docs.map((doc) {
      final json = doc.data();
      json['id'] = doc.id;

      return _mapper.parser(json);
    }).toList();
  }

  Future<void> updateDocument(String id, Map<String, dynamic> data) {
    return collectionRef.doc(id).update(data);
  }

  Future<void> deleteDocument(String id, Map<String, dynamic> data) {
    return collectionRef.doc(id).delete();
  }
}
