import 'package:flutter/material.dart';
import 'package:frontend/app.dart';
import 'package:frontend/pages/account/historique.dart';
import 'package:frontend/pages/account/info_paiement.dart';
import 'package:frontend/pages/account/user_infos.dart';
import 'package:frontend/pages/auth/login.dart';
import 'package:frontend/pages/cart_view.dart';
import 'package:frontend/providers/navbar_provider.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:frontend/widgets/dialog_alert.dart';
import 'package:provider/provider.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  late String userName =
      "${Provider.of<UserProvider>(context, listen: false).currentUser!.firstName} ${Provider.of<UserProvider>(context, listen: false).currentUser!.lastName}";

  late String userEmail =
      Provider.of<UserProvider>(context, listen: false).currentUser!.email;

  logout() {
    Navigator.pop(context, 'Cancel');
    Provider.of<NavBarProvider>(context, listen: false).changePage(1);
    Provider.of<UserProvider>(context, listen: false).resetCurrentUSer();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return const App();
      }),
      (r) {
        return false;
      },
    );
  }

  void profileAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserInfosPage()),
    );
  }

  historiqueAction() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const UserInfosPage()),
    // );
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HistoriquePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // CircleAvatar(
                    //   radius: (MediaQuery.of(context).size.width * 0.25),
                    //   backgroundColor: Colors.white,
                    //   child: CircleAvatar(
                    //     radius: (MediaQuery.of(context).size.width * 0.25),
                    //     backgroundImage: NetworkImage(
                    //       'INSERT_URL_HERE',
                    //     ),
                    //     backgroundColor: Colors.green,
                    //     child: Padding(
                    //       padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
                    //       child: Align(
                    //         alignment: Alignment.bottomRight,
                    //         child: Icon(
                    //           Icons.verified_rounded,
                    //           color: Colors.blue,
                    //           size: MediaQuery.of(context).size.width * 0.25,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width * 0.17),
                      height: (MediaQuery.of(context).size.width * 0.17),
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: "userIconBtn",
                          backgroundColor: Color.fromARGB(255, 100, 100, 100),
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserInfosPage()),
                              )),
                          child: Icon(
                            Icons.person,
                            size: (MediaQuery.of(context).size.width * 0.1),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextButton(
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserInfosPage()),
                              )),
                          child: Text(
                            userName,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          userEmail,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    // Icon(
                    //   Icons.arrow_right,
                    //   color: const Color.fromARGB(255, 136, 136, 136),
                    //   // size: 46.0,
                    //   size: MediaQuery.of(context).size.width * 0.12,
                    //   semanticLabel: 'User Icon',
                    // ),
                    IconButton(
                      onPressed: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfosPage()),
                          )),
                      icon: Icon(
                        Icons.arrow_right,
                        color: const Color.fromARGB(255, 136, 136, 136),
                        // size: 46.0,
                        size: MediaQuery.of(context).size.width * 0.12,
                        semanticLabel: 'User Icon',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                // padding: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Paramètres du compte",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyWidget(
                      title: "Informations personnelles",
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfosPage()),
                          )),
                      function: (String val) {
                        // print('I am a function with A return value');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserInfosPage()),
                        );
                      },
                      config: 'bottom',
                    ),

                    // ElevatedButton(
                    //   onPressed: () {},
                    //   style: ElevatedButton.styleFrom(
                    //     foregroundColor: Colors.black,
                    //     backgroundColor: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(6.0),
                    //       side: const BorderSide(
                    //           width: 1, // thickness
                    //           color: Color.fromARGB(255, 221, 221, 221) // color
                    //           ),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: const [
                    //       Text(
                    //         'Historique des Commandes',
                    //         style: TextStyle(color: Colors.black),
                    //       ), // <-- Text
                    //       // SizedBox(
                    //       //   width: 5,
                    //       // ),
                    //       Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 24.0,
                    //         color: Color.fromARGB(255, 139, 139, 139),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // padding: const EdgeInsets.all(0),
                padding: const EdgeInsets.only(top: 8, left: 10, right: 10),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Commandes",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // FilledCardExample(
                    //   action: (() => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const UserInfosPage()),
                    //       )),
                    //   title: 'Historique',
                    // ),
                    // FilledCardExample(),
                    MyWidget(
                      // onTap: () {
                      //   print('I am a function with NO return value');
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const HistoriquePage()),
                      //   );
                      // },
                      title: "Historique des commandes",
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoriquePage()),
                          )),
                      function: (String val) {
                        // print('I am a function with A return value');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HistoriquePage()),
                        );
                      },
                      config: 'in',
                    ),
                    MyWidget(
                      title: "Informations de paiement",
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InfoPaiementPage()),
                          )),
                      function: (String val) {
                        // print('I am a function with A return value');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InfoPaiementPage()),
                        );
                      },
                      config: 'bottom',
                    ),
                    // ElevatedButton(
                    //   onPressed: () {},
                    //   style: ElevatedButton.styleFrom(
                    //     foregroundColor: Colors.black,
                    //     backgroundColor: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(6.0),
                    //       side: const BorderSide(
                    //           width: 1, // thickness
                    //           color: Color.fromARGB(255, 221, 221, 221) // color
                    //           ),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.max,
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: const [
                    //       Text(
                    //         'Historique des Commandes',
                    //         style: TextStyle(color: Colors.black),
                    //       ), // <-- Text
                    //       // SizedBox(
                    //       //   width: 5,
                    //       // ),
                    //       Icon(
                    //         Icons.arrow_forward_ios,
                    //         size: 24.0,
                    //         color: Color.fromARGB(255, 139, 139, 139),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Logout"),
                    // content: Text(content),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context, 'Cancel'),
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => {logout()},
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.redAccent),
                  textStyle:
                      MaterialStateProperty.all<TextStyle>(const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  )),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FilledCardExample extends StatelessWidget {
  const FilledCardExample(
      {super.key, required this.title, required this.action});

  final String title;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // onPressed: () => {action},
      onPressed: action,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: const BorderSide(
              width: 1, // thickness
              color: Color.fromARGB(255, 221, 221, 221) // color
              ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ), // <-- Text
          // SizedBox(
          //   width: 5,
          // ),

          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 24.0,
              color: Color.fromARGB(255, 139, 139, 139),
            ),
            tooltip: "Voir plus",
            // onPressed: () {
            //   action;
            // },
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
//Declare the functions
  final Function()? onTap;
  final Function(String val) function;
  final String title;
  final String config;

  const MyWidget({
    super.key,
    required this.onTap,
    required this.function,
    required this.title,
    required this.config,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // onPressed: () => {action},
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: const BorderSide(
              width: 1, // thickness
              color: Color.fromARGB(255, 221, 221, 221) // color
              ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ), // <-- Text
          // SizedBox(
          //   width: 5,
          // ),

          IconButton(
            icon: const Icon(
              Icons.arrow_forward_ios,
              size: 24.0,
              color: Color.fromARGB(255, 139, 139, 139),
            ),
            tooltip: "Voir plus",
            // onPressed: () {
            //   action;
            // },
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
