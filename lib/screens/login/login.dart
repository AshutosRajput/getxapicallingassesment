import 'package:assignmentjoyistick/utility/uihelper/allpackages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Login extends StatelessWidget {
  final GoogleSignInService _googleSignInService = GoogleSignInService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SizedBox(
            height: screnSize.height,
            width: screnSize.width,
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TouchRippleEffect(
                  onTap: () async {
                    User? user= await _googleSignInService.signInWithGoogle();


                    // print(user!.email);
                    if (user != null) {
                     UiHelper.showSnackbar(context,'Login SuccessFully');
                     Get.toNamed(AppRoutes.home);
                    } else {

                      UiHelper.showSnackbar(context,'Login Failed');
                    }
                  },
                  rippleColor: Colors.grey,
                  child: Material(
                    elevation: 12,
                    child: Container(
                      alignment: Alignment.center,
                      height: screnSize.height*.06,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12)
                          ,
                                  border: Border.all(color: Colors.grey,width: 1)        ),

                      width: screnSize.width*.9,
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(Appimages.googleButton,height: 24,),
                          SizedBox(width: 40,),
                          UiHelper.heading(
                              Appstring.loginwidthgoogle,Colors.grey,18)
                        ],
                      )

                    ),
                  ),
                )

                                ],
            )
    ))
    );
  }
}
