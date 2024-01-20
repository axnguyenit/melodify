import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/constants/constants.dart';
import 'package:domain/domain.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:injectable/injectable.dart';

@Injectable(as: UserService)
class UserServiceImpl extends BaseFirestoreService<User>
    implements UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepository;

  UserServiceImpl(this._userRepository)
      : super(
          collectionRef:
              FirebaseFirestore.instance.collection(Collections.users),
          mapper: Mapper<User>(
            parser: User.fromJson,
          ),
        );

  @override
  Future<User> getProfile() async {
    return (await getUserById(_auth.currentUser!.uid))!;
  }

  @override
  Future<User?> getUserById(String id) async {
    return getDocument(id);
  }

  @override
  void registerDeviceTokenIfNeeded({
    required String deviceToken,
    bool forceUpToDate = false,
  }) {}

  @override
  Future<void> unregisterDeviceToken() {
    return _userRepository.unregisterDeviceToken();
  }

  @override
  Future<void> signOut() {
    return _userRepository.signOut();
  }

  @override
  Future<void> signIn(String email, String password) {
    return _userRepository.signIn(email, password);
  }

  @override
  Future<bool> emailAlreadyExists(String email) async {
    final methods = await _auth.fetchSignInMethodsForEmail(email);

    return methods.isNotEmpty;
  }

  @override
  Future<User> createUserProfile(ProfileCreationRequest request) async {
    await collectionRef.doc(_auth.currentUser!.uid).set(request.toJson());

    return (await getUserById(_auth.currentUser!.uid))!;
  }

  @override
  Future<bool> isEmailAlreadyExists(String email) async {
    final snapshot = await collectionRef.where('email', isEqualTo: email).get();

    return snapshot.docs.isNotEmpty;
  }

  @override
  Future<bool> isPhoneAlreadyExists(String phone) async {
    final snapshot = await collectionRef.where('phone', isEqualTo: phone).get();

    return snapshot.docs.isNotEmpty;
  }
}
