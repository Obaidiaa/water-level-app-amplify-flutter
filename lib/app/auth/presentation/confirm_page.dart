// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/services/auth_services.dart';

// class ConfirmPage extends ConsumerStatefulWidget {
//   const ConfirmPage({Key? key, this.email}) : super(key: key);
//   final String? email;
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _ConfirmPageState();
// }

// class _ConfirmPageState extends ConsumerState<ConfirmPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _codeController = TextEditingController();
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
//                 'Confirm User',
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
//                       initialValue: widget.email,
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
//                       controller: _codeController,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.confirmation_num),
//                         hintText: 'Confirmation Code',
//                         labelText: 'Confirmation Code',
//                       ),
//                       // The validator receives the text that the user has entered.
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Confirmation Code';
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
//                                 'Confirming',
//                                 textAlign: TextAlign.center,
//                               )),
//                             );

//                             ref
//                                 .read(registerUserProvider)
//                                 .confirmUser(
//                                   _emailController.text,
//                                   _codeController.text,
//                                 )
//                                 .then((value) {
//                               ScaffoldMessenger.of(context).clearSnackBars();
//                               if (value['Success']) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       backgroundColor: Colors.green,
//                                       content: Text(
//                                         'Register succeed',
//                                         textAlign: TextAlign.center,
//                                       )),
//                                 );
//                               } else {
//                                 ScaffoldMessenger.of(context).clearSnackBars();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       backgroundColor: Colors.red,
//                                       content: Text(
//                                         value['Message'],
//                                         textAlign: TextAlign.center,
//                                       )),
//                                 );
//                               }
//                             });
//                           }
//                         },
//                         child: const Text('Submit'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }
