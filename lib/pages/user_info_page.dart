// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';

// class UserInfoPage extends StatelessWidget {
//   const UserInfoPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Info'),
//       ),
//       body: FutureBuilder(
//           future: GetIt.instance.get<UserManager>().getUserInfo(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: Text('Loading...'));
//             }
//             if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             }
//             if (snapshot.hasData) {
//               final data = snapshot.data;
//               if (data == null) {
//                 return EmptyDataWidget();
//               }
//               return UserInfoBody(data: data);
//             }
//             return EmptyDataWidget();
//           }),
//     );
//   }
// }

// class UserInfoBody extends StatelessWidget {
//   const UserInfoBody({super.key, required this.data});

//   final UserInfo data;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: data.vehicleIds.map((e) => Text(e)).toList(),
//     );
//   }
// }

// class EmptyDataWidget extends StatelessWidget {
//   const EmptyDataWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text('No data'));
//   }
// }
