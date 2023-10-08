import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          children: [
            buildDrawerHeader(),
            const Divider(
              color: Colors.grey,
            ),
            buildDrawerItem(
              icon: Icons.photo,
              text: "Home",
              onTap: () => navigate(0),
              tileColor: Get.currentRoute == '/home' ? Colors.blue : null,
              textIconColor:
                  Get.currentRoute == '/home' ? Colors.white : Colors.black,
            ),
            buildDrawerItem(
              icon: Icons.photo,
              text: "Home add",
              onTap: () => navigate(1),
              tileColor: Get.currentRoute == '/home_add' ? Colors.blue : null,
              textIconColor:
                  Get.currentRoute == '/home_add' ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader() {
    return const UserAccountsDrawerHeader(
      accountName: Text("Ripples Code"),
      accountEmail: Text("ripplescode@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YXZhdGFyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
      ),
      currentAccountPictureSize: Size.square(72),
      otherAccountsPictures: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text("RC"),
        )
      ],
      otherAccountsPicturesSize: Size.square(50),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required IconData icon,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textIconColor),
      title: Text(
        text,
        style: TextStyle(color: textIconColor),
      ),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

  navigate(int index) {
    if (index == 0) {
      Get.toNamed('/home');
    } else if (index == 1) {
      Get.toNamed('/home_add');
    }
    if (index == 2) {
      Get.toNamed('/home_edit');
    }
  }
}



// import 'package:flutter/material.dart';

// import '../../../modules/home/home_page.dart';

// class CustomDrawer extends StatelessWidget {
//   const CustomDrawer({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             decoration: const BoxDecoration(
//               color: Colors.green,
//             ),
//             child: Center(
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Icon(
//                       Icons.account_circle,
//                       color: Colors.white,
//                       size: 40,
//                     ),
//                     flex: 2,
//                   ),
//                   Expanded(
//                     flex: 6,
//                     child: Text('fvsf'
//                         // style: const TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ListTile(
//             title: const Text("Home"),
//             leading: IconButton(
//               icon: const Icon(Icons.home),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             onTap: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => HomePage()));
//             },
//           ),
//           const Divider(
//             color: Colors.grey,
//           ),
//           ListTile(
//             title: const Text("Profile"),
//             leading: IconButton(
//               icon: const Icon(Icons.account_circle),
//               onPressed: () {},
//             ),
//             onTap: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => HomePage()));
//             },
//           ),
//           const Divider(
//             color: Colors.grey,
//           ),
//           ListTile(
//             title: const Text("Contact"),
//             leading: IconButton(
//               icon: const Icon(Icons.contact_page),
//               onPressed: () {},
//             ),
//             onTap: () {
//               Navigator.of(context).pop();
//               Navigator.of(context).push(MaterialPageRoute(
//                   builder: (BuildContext context) => HomePage()));
//             },
//           ),
//           const Divider(
//             color: Colors.grey,
//           ),
//           ListTile(
//             title: const Text("Sair"),
//             leading: IconButton(
//               icon: const Icon(Icons.contact_page),
//               onPressed: () {},
//             ),
//             onTap: () {
//               // Get.find<AuthService>().logout();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
