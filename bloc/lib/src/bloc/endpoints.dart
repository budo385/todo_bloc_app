
abstract class Endpoints<D, C> {

  final String userCollectionName = "users";
  final String todoCollectionName = "todos";

  String userId;

  C userCollectionEndpoint;
  C get todoCollectionEndpoint;

  void logout() {
    userId = null;
  }
}