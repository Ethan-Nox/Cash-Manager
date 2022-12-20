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
import 'package:frontend/widgets/userAccount/accountList.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ElevatedButton(
                // padding: const EdgeInsets.all(0),
                style: ElevatedButton.styleFrom(
                    // primary: Colors.transparent,
                    elevation: 0,
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Colors.transparent),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInfosPage()),
                  );
                },
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
                      width: (70),
                      height: (70),
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: "userIconBtn",
                          backgroundColor: const Color.fromARGB(255, 100, 100, 100),
                          onPressed: (() => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UserInfosPage()),
                              )),
                          child: Icon(
                            Icons.person,
                            size: (40),
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
                              color: Color.fromARGB(255, 88, 88, 88),
                            ),
                          ),
                        ),
                        Text(
                          userEmail,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
                    UserAccountList(
                      title: "Informations personnelles",
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UserInfosPage()),
                          )),
                      config: 'bottom',
                    ),
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
                    UserAccountList(
                      title: "Historique des commandes",
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HistoriquePage()),
                          )),
                      config: 'in',
                    ),
                    UserAccountList(
                      title: "Informations de paiement",
                      onTap: (() => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const InfoPaiementPage()),
                          )),
                      config: 'bottom',
                    ),
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
                    // title: const Text("Logout"),
                    title: const Text("Logout"),
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
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  // padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  //   const EdgeInsets.all(10),
                  // ),
                ),
                // child: const Text(
                //   "Logout",
                //   style: TextStyle(color: Colors.white),
                // ),
                child: Icon(
                  Icons.logout,
                  color: Colors.white,
                  // size: MediaQuery.of(context).size.width * 0.05,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
