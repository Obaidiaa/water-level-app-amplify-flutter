// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:water_level_flutter/app/auth/login_page.dart';
// import 'package:water_level_flutter/services/auth_services.dart';

// class RegisterPage extends ConsumerStatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends ConsumerState<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _passwordController = TextEditingController();
//   final _passwordConfirmationController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _addressController = TextEditingController();

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
//                 'Register',
//                 style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.person),
//                         hintText: 'Full Name',
//                         labelText: 'Name ',
//                       ),
//                       // The validator receives the text that the user has entered.
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your Name';
//                         }
//                         return null;
//                       },
//                     ),
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
//                       controller: _phoneController,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.phone),
//                         hintText: 'Phone Number',
//                         labelText: 'Phone Number',
//                       ),
//                       // The validator receives the text that the user has entered.
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Phone Number';
//                         }

//                         bool phoneValid = RegExp(
//                                 r"^[\+]?[(]?[05]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$")
//                             .hasMatch(value);
//                         if (!phoneValid) {
//                           return 'Please Enter valid phone number';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _addressController,
//                       decoration: const InputDecoration(
//                         icon: Icon(Icons.phone),
//                         hintText: 'City',
//                         labelText: 'City',
//                       ),
//                       // The validator receives the text that the user has entered.
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter Address';
//                         }

//                         // bool phoneValid = RegExp(
//                         //         r"^[\+]?[(]?[05]{2}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{5}$")
//                         //     .hasMatch(value);
//                         // if (!phoneValid) {
//                         //   return 'Please Enter valid phone number';
//                         // }
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
//                         if (_passwordController.text !=
//                             _passwordConfirmationController.text) {
//                           return 'Password not matching';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       autovalidateMode: AutovalidateMode.onUserInteraction,
//                       controller: _passwordConfirmationController,
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
//                         if (_passwordController.text !=
//                             _passwordConfirmationController.text) {
//                           return 'Password not matching';
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
//                                 'Registering',
//                                 textAlign: TextAlign.center,
//                               )),
//                             );

//                             ref
//                                 .read(registerUserProvider)
//                                 .signUpUser(
//                                     _emailController.text,
//                                     _passwordController.text,
//                                     _nameController.text,
//                                     _phoneController.text,
//                                     _addressController.text)
//                                 .then((value) {
//                               ScaffoldMessenger.of(context).clearSnackBars();
//                               if (value['Success']) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                       backgroundColor: Colors.green,
//                                       content: Text(
//                                         'registration successful please check your Email',
//                                         textAlign: TextAlign.center,
//                                       )),
//                                 );
//                                 Navigator.pop(context);
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
