import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:firebase_core/firebase_core.dart";

FirebaseApp app = Firebase.app();
FirebaseDatabase db = FirebaseDatabase.instanceFor(app: app);
FirebaseAuth auth = FirebaseAuth.instanceFor(app: app);
