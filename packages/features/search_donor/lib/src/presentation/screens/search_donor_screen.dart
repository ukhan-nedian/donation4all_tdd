import 'package:design_system/design_system.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:search_donor/src/presentation/bloc/search_donor_bloc.dart';

class SearchDonorScreen extends StatefulWidget {
  const SearchDonorScreen({super.key});

  @override
  State<SearchDonorScreen> createState() => _SearchDonorScreenState();
}

class _SearchDonorScreenState extends State<SearchDonorScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  late SearchDonorBloc bloc;

  DateTime timeBackPressed = DateTime.now();

  @override
  void initState() {
    bloc = BlocProvider.of<SearchDonorBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isExitWarning) {
          const message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message);
        } else {
          Fluttertoast.cancel();
        }
      },
      child: Scaffold(
        body: Container(
          height: SizeConfig.height(context, 1),
          decoration: const BoxDecoration(
            gradient: GlobalColors.backgroundGradient,
          ),
          child: Column(
            children: [
              Hero(
                tag: 'donation_logo',
                child: SizedBox(
                  height: SizeConfig.height(context, 0.15),
                  // padding: EdgeInsets.all(SizeConfig.width(context, 0.01)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.width(context, 0.05),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Opacity(
                            //   opacity: 0.0,
                            //   child: GestureDetector(
                            //     onTap: () {},
                            //     // child: Image.asset('assets/icons/drawer_icon.png'),
                            //     child: const Icon(
                            //       Icons.arrow_back,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // ),
                            // Image.asset('assets/images/donation_logo.png'),
                            // Image.asset('assets/images/donation4all_logo.png'),
                            // Opacity(
                            //   opacity: 0.0,
                            //   child:
                            //   Image.asset('assets/icons/drawer_icon.png'),
                            // ),
                            // SizedBox(width: SizeConfig.width(context, 0.05)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(SizeConfig.width(context, 0.4)),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width(context, 0.06),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            SizeConfig.width(context, 0.4),
                          ),
                        ),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(height: SizeConfig.height(context, 0.04)),

                          /// STEP 1 HEADING
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              'ENTER YOUR EMAIL',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                fontSize: SizeConfig.width(context, 0.06),
                                fontWeight: FontWeight.bold,
                                color: GlobalColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.height(context, 0.03)),

                          /// Email
                          DonationTextFormField(
                            key: const Key('email_text_field'),
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: emailValidation,
                          ),
                          SizedBox(height: SizeConfig.width(context, 0.05)),

                          /// Signup Button
                          BlocConsumer<SearchDonorBloc, SearchDonorState>(
                            listener: (context, state) {
                              if (state is DonorNotFound) {
                                // Navigator.of(context).pushNamed(
                                //   // AppRoutes.homeScreenRoute,
                                //   AppRoutes.signupScreen2Route,
                                //   arguments: SignUpScreen2Args(
                                //     userDonor: null,
                                //     email: emailController.text,
                                //   ),
                                // );
                              }
                              if (state is DonorFound) {
                                if (state.userDonor.loginType == 'mobile') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'An account with email ${emailController
                                            .text} already exists',
                                      ),
                                    ),
                                  );
                                } else {
                                  // Navigator.of(context).pushNamed(
                                  //   // AppRoutes.homeScreenRoute,
                                  //   AppRoutes.signupScreen2Route,
                                  //   arguments: SignUpScreen2Args(
                                  //     userDonor: state.userDonor,
                                  //     email: emailController.text,
                                  //   ),
                                  // );
                                }
                              }
                            },
                            builder: (context, state) {
                              if (state is SearchingDonor) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return AppButton(
                                key: const Key('submit_button'),
                                buttonText: 'Submit',
                                onPressed: () {
                                  /*Navigator.of(context).pushNamed(
                                    AppRoutes.otpScreenRoute,
                                    arguments: OtpScreenArgs(
                                      email: emailController.text,
                                    ),
                                  );*/
                                  /*Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => const SignInScreen(),
                                    ),
                                  );*/
                                  if (_formKey.currentState!.validate()) {
                                    // bloc.searchDonor(emailController.text);
                                    bloc.add(
                                      OnSubmitButtonPressed(
                                        email: emailController.text,
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                          SizedBox(height: SizeConfig.height(context, 0.02)),

                          /// Already have an account? Sign In
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Already have an account?',
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .bodyMedium
                          //           ?.copyWith(
                          //         fontSize: SizeConfig.width(context, 0.04),
                          //         color: const Color(0xff4E4D4D),
                          //         fontWeight: FontWeight.w300,
                          //       ),
                          //     ),
                          //     InkWell(
                          //       onTap: () {
                          //         /*Navigator.of(context).pushReplacement(
                          //           MaterialPageRoute(
                          //             builder: (context) => const SignInScreen(),
                          //           ),
                          //         );*/
                          //         // Navigator.of(context).pushNamedAndRemoveUntil(
                          //         //   AppRoutes.signinScreenRoute,
                          //         //       (route) => false,
                          //         // );
                          //       },
                          //       child: Text(
                          //         '  Sign In',
                          //         style: TextStyle(
                          //           fontSize: SizeConfig.width(context, 0.04),
                          //           color: const Color(0xff4E4D4D),
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          BlocBuilder<SearchDonorBloc, SearchDonorState>(
                            builder: (context, state) {if (state is DonorFound) {
                                return Center(
                                  key: const Key('user_donor_text'),
                                  child: Text('${state.userDonor}'),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                          SizedBox(height: SizeConfig.height(context, 0.03)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? emailValidation(String? value) {
    if (value == null) {
      return 'required';
    }
    if (value.isEmpty) {
      return 'Please enter email address';
    }
    if (!EmailValidator.validate(value)) {
      return 'Invalid Email address';
    }
    return null;
  }
}