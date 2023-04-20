import 'package:basics_samples/cubits/all_users_page/all_users_page_cubit.dart';
import 'package:basics_samples/cubits/all_users_page/all_users_state.dart';
import 'package:basics_samples/cubits/auth/auth_cubit.dart';
import 'package:basics_samples/models/app_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users list'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthCubit>().signOut();
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: BlocBuilder<AllUsersCubit, AllUsersState>(
        builder: (context, state) {
          if (state is AllUsersLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AllUsersFailure) {
            return Center(child: const Text('An error occured'));
          } else if (state is AllUsersComplete) {
            final appUsers = state.users;
            return _AppUsersList(
              appUsers: appUsers,
              cubit: context.read<AllUsersCubit>(),
            );
          }
          return SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final currentUid = FirebaseAuth.instance.currentUser?.uid;
          final docRef = FirebaseFirestore.instance.collection('orders').doc();

          docRef.set(
            {
              'product': 'product',
              'total': 'total',
              'seller': currentUid,
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _AppUsersList extends StatelessWidget {
  const _AppUsersList({
    required this.appUsers,
    required this.cubit,
  });

  final List<AppUser> appUsers;
  final AllUsersCubit cubit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appUsers.length,
      itemBuilder: (BuildContext context, int index) {
        final appUser = appUsers[index];

        // Do not have this logic here but in a cloud functions instead
        final currentUser = context.read<AuthCubit>().state.currentUser;

        final isFollowing = currentUser?.followings.contains(appUser.uid);

        return ListTile(
          title: Text(appUsers[index].username),
          trailing: IconButton(
            onPressed: () {
              if (isFollowing == true) {
                cubit.unfollowUser(appUser.uid);
              } else {
                cubit.followUser(appUser.uid);
              }
            },
            icon: isFollowing == true ? Icon(Icons.star) : Icon(Icons.star_border),
          ),
        );
      },
    );
  }
}
