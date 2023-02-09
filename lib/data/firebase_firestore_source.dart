import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseFirestoreSource {
  final firebase = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  Future<List<Poll>> fetchUserPolls() async {
    final currentUser = auth.currentUser;
    if (currentUser == null) throw Exception('user-is-signed-out, impossible to fetch user polls');
    
    final snapshot = await firebase
        .collection('polls')
        .where('authorId', isEqualTo: currentUser.uid)
        .get();

    final polls = snapshot.docs.map((doc) => Poll.fromJson(doc.data())).toList();

    polls.sort((a, b) => a.lastUpdatedDate.compareTo(b.lastUpdatedDate));
    polls.forEach((poll) => print(poll.lastUpdatedDate));
    return polls;
  }
}

class Poll {
  final DateTime createdDate;
  final DateTime lastUpdatedDate;
  final String authorId;
  final String name;

  const Poll({
    required this.createdDate,
    required this.lastUpdatedDate,
    required this.authorId,
    required this.name,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      createdDate: (json['createdAt'] as Timestamp).toDate(),
      lastUpdatedDate: (json['lastUpdatedAt'] as Timestamp).toDate(),
      authorId: json['authorId'] as String,
      name: json['event']['title'] as String,
    );
  }
}

// fromJson(Timestamp json) => json.toDate();