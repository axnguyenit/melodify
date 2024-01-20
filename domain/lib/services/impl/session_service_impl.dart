import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SessionService)
class SessionServiceImpl implements SessionService {
  final _auth = FirebaseAuth.instance;

  @override
  Future<String?> getCurrentSession() async {
    return _auth.currentUser?.getIdToken();
  }
}
