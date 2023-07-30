// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/app/auth/register_page.dart';
// import 'package:water_level_flutter/routing/app_router.dart';
// import 'package:water_level_flutter/services/auth_notifier.dart';
// import 'package:water_level_flutter/services/auth_services.dart';

// class LoginPage extends ConsumerStatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   // static Future<void> show(BuildContext context) async {
//   //   await Navigator.of(context, rootNavigator: true).pushNamed(
//   //     AppRoutes.LoginPage,
//   //     // arguments: settings,
//   //   );
//   // }

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
// }

// class _LoginPageState extends ConsumerState<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _passwordController = TextEditingController();
//   final _emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(50.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Login',
//                 style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.email),
//                         hintText: 'Email',
//                         labelText: 'Email ',
//                       ),
//                       // The validator receives the text that the user has entered.
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Your Email';
//                         }

//                         bool emailValid = RegExp(
//                                 r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                             .hasMatch(value);

//                         if (!emailValid) {
//                           return 'Please enter valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _passwordController,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.password),
//                         hintText: 'Password',
//                         labelText: 'Password',
//                       ),
//                       // The validator receives the text that the user has entered.
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'password can\'t be empty';
//                         }
//                         return null;
//                       },
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 16.0),
//                       child: ElevatedButton(
//                         onPressed: () async {
//                           // Validate returns true if the form is valid, or false otherwise.
//                           if (_formKey.currentState!.validate()) {
//                             // If the form is valid, display a snackbar. In the real world,
//                             // you'd often call a server or save the information in a database.
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                 'Sgining in',
//                                 textAlign: TextAlign.center,
//                               )),
//                             );

//                             ref
//                                 .read(authNotifierProvider.notifier)
//                                 .signInUser(_emailController.text,
//                                     _passwordController.text)
//                                 .then(
//                                   (value) => value.when(
//                                       data: (data) {
//                                         ScaffoldMessenger.of(context)
//                                             .clearSnackBars();
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           const SnackBar(
//                                               backgroundColor: Colors.green,
//                                               content: Text(
//                                                 'Register succeed',
//                                                 textAlign: TextAlign.center,
//                                               )),
//                                         );
//                                       },
//                                       error: ((error, stackTrace) {
//                                         ScaffoldMessenger.of(context)
//                                             .clearSnackBars();
//                                         ScaffoldMessenger.of(context)
//                                             .showSnackBar(
//                                           SnackBar(
//                                               backgroundColor: Colors.red,
//                                               content: Text(
//                                                 '$error',
//                                                 textAlign: TextAlign.center,
//                                               )),
//                                         );
//                                       }),
//                                       loading: () =>
//                                           const CircularProgressIndicator()),
//                                 );
//                             // );
//                             // .then((value) {
//                             // ScaffoldMessenger.of(context).clearSnackBars();

//                             // if (value['Success']) {
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //     const SnackBar(
//                             //         backgroundColor: Colors.green,
//                             //         content: Text(
//                             //           'Register succeed',
//                             //           textAlign: TextAlign.center,
//                             //         )),
//                             //   );
//                             // } else {
//                             //   ScaffoldMessenger.of(context).clearSnackBars();
//                             //   ScaffoldMessenger.of(context).showSnackBar(
//                             //     SnackBar(
//                             //         backgroundColor: Colors.red,
//                             //         content: Text(
//                             //           value['Message'],
//                             //           textAlign: TextAlign.center,
//                             //         )),
//                             //   );
//                             // }
//                             // });
//                           }
//                         },
//                         child: const Text('Submit'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                   onPressed: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const RegisterPage()),
//                       ),
//                   child: const Text('Register'))
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
