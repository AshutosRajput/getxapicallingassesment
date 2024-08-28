import 'package:assignmentjoyistick/utility/uihelper/allpackages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Home extends StatelessWidget {
  Home({super.key});

  final ApiController controller = Get.put(ApiController());
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () async {
      // Show a confirmation dialog when the back button is pressed
      final shouldPop = await _showExitConfirmationDialog(context);
      return shouldPop;
       },

        child: Scaffold(
          body: SafeArea(
              child: SizedBox(
            height: screnSize.height,
            width: screnSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18),
              child: Column(
                children: [
                  header(context),
                  const SizedBox(
                    height: 30,
                  ),
                  companies()
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Obx(() {
      return controller.showHeader.value
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.vertical_distribute, color: Colors.black),
                    controller.showSearchField.value
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 12),
                              child: TextField(
                                onSubmitted: (data) {
                                  FocusScope.of(context).unfocus();
                                },
                                focusNode: _focusNode,
                                onChanged: (value) {
                                  controller.search(value);
                                },
                                decoration: const InputDecoration(
                                    hintText: Appstring.companySearch,
                                    contentPadding: EdgeInsets.all(10),
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.search)),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    controller.showSearchField.value
                        ? const SizedBox.shrink()
                        : GestureDetector(
                            onTap: controller.toggleSearchField,
                            child: Container(
                              width: screnSize.width * .16,
                              height: screnSize.height * .04,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: Colors.grey, width: .6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.search, size: 30),
                            ),
                          ),
                  ],
                ),
                const SizedBox(height: 30),
                UiHelper.heading(Appstring.homeDes, Colors.black, 40),
              ],
            )
          : const SizedBox(); // Hide the header
    });
  }

  Widget companies() {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError.value) {
          return const Center(child: Text('Failed to load data'));
        } else if (controller.companyList.isEmpty) {
          return const Center(child: Text('No companies available'));
        } else {
          return controller.allCompanies.isEmpty
              ? Center(
                  child: UiHelper.subHeading(Appstring.noResult, Colors.grey),
                )
              : ListView.builder(
                  itemCount: controller.allCompanies.length,
                  itemBuilder: (context, index) {
                    var company = controller.companyList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(12),
                        child: TouchRippleEffect(
                          onTap: () {
                            controller.showHeaderFunction();
                            controller.toggleSearchField();
                            showModalBottomSheet(
                                isDismissible: false,
                                isScrollControlled: true,
                                backgroundColor: Colors.white,
                                context: context,
                                builder: (context) => bottomsheetData(
                                    company.title
                                        .split(' ')
                                        .take(2)
                                        .join(' ')
                                        .toUpperCase(),
                                    context,
                                    index));
                          },
                          rippleColor: Colors.grey,
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 90,
                            width: screnSize.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 26,
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child:
                                          Image.network(company.thumbnailUrl),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      UiHelper.subHeading(
                                          company.title
                                              .split(' ')
                                              .take(2)
                                              .join(' '),
                                          Colors.black),
                                      SizedBox(
                                        width: screnSize.width * .54,
                                        child: UiHelper.subHeading1(
                                            company.title, Colors.grey),
                                      )
                                    ],
                                  ),
                                  const Spacer(),
                                  Obx(() => CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            controller.jobStatus[index]
                                                ? Colors.green
                                                : Colors.purple,
                                        child: Container(
                                          height: 10,
                                          width: 10,
                                          color: Colors.white,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        }
      }),
    );
  }

  Widget bottomsheetData(String companyName, BuildContext context, int index) {
    return SizedBox(
      width: screnSize.width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 496,
            left: screnSize.width * .08,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.grey[200],
                  child: SvgPicture.asset(Appimages.googleButton)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 160,
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiHelper.heading(companyName, Colors.black, 18),
                      const Icon(
                        Icons.star,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  UiHelper.subHeading(Appstring.dfon, Colors.grey),
                  const SizedBox(
                    height: 14,
                  ),
                  UiHelper.subHeading(Appstring.techBased, Colors.grey),
                  const SizedBox(
                    height: 20,
                  ),
                  UiHelper.subHeading(Appstring.position, Colors.grey),
                  const SizedBox(
                    height: 10,
                  ),
                  UiHelper.heading(Appstring.positionName, Colors.black, 16),
                  const SizedBox(
                    height: 20,
                  ),
                  UiHelper.subHeading(Appstring.jobDescription, Colors.grey),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screnSize.width,
                    child: UiHelper.subHeading(
                        Appstring.qualification, Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TouchRippleEffect(
                    onTap: () {
                      controller.showHeaderFunction();
                      Navigator.pop(context);
                      if (controller.jobStatus[index] == true) {
                        UiHelper.showSnackbar(
                            context, Appstring.alreadyAppliedMessage);
                      } else {
                        controller.changeJobStatus(index);
                        UiHelper.showSnackbar(
                            context, Appstring.successMessage);
                      }
                    },
                    rippleColor: Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: screnSize.width,
                      decoration: BoxDecoration(
                        color: controller.jobStatus[index]
                            ? Colors.green
                            : Colors.purple,
                        border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                            width: 2), // Define the border

                        borderRadius:
                            BorderRadius.circular(12), // Border radius
                      ),
                      child: UiHelper.subHeading(
                          controller.jobStatus[index]
                              ? Appstring.alreadyApplied
                              : Appstring.apply,
                          Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Exit Confirmation'),
        content: Text('Do you really want to exit?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    ) ?? false; // Return false if the dialog is dismissed without any action
  }
}
