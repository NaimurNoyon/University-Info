import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:university_info/screens/webview_screen.dart';
import 'package:university_info/utils/colors.dart';
import 'package:university_info/widgets/shimmer.dart';

import '../controllers/data_controller.dart';
import '../widgets/snackbar_message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DataController controller = Get.put(DataController());
    return GetBuilder<DataController>(builder: (dataController) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: 100,
                decoration: const BoxDecoration(
                  color: AppColors.colorPrimary
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12,),
                    const Text(
                        "Universities",
                      style: TextStyle(
                        color: AppColors.colorWhite,
                        fontSize: 28,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.setIconDirection(true);
                        showCountryPicker(
                          useSafeArea: true,
                          context: context,
                          showPhoneCode: false,
                          showSearch: true,
                          onSelect: (Country country) {
                            if (kDebugMode) {
                              print('Select country: ${country.name}');
                            }
                            controller.selectCountry(country.name);
                          },
                          onClosed: () {
                            controller.setIconDirection(false);
                          },
                          countryListTheme: const CountryListThemeData(
                            //backgroundColor: Colors.blue,
                            bottomSheetHeight: 500,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            // Optional. Styles the search field.
                            inputDecoration: InputDecoration(
                              //isCollapsed: true,
                              contentPadding: EdgeInsets.all(10),
                              //labelText: 'Search',
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                              hoverColor: Colors.red,
                              focusColor: Colors.red,
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 18),
                              prefixIcon: Icon(Icons.search),
                              alignLabelWithHint: true,
                            ),
                            // Optional. Styles the text in the search field
                            searchTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          controller.iconUp
                              ? const Icon(
                              Icons.arrow_drop_up,
                            color: Colors.white,
                            size: 22,
                          )
                              : const Icon(
                              Icons.arrow_drop_down,
                            color: AppColors.colorSecondary,
                            size: 22,
                          ),
                          Text(
                              dataController.countryName,
                            style: TextStyle(
                              color: AppColors.colorSecondary,
                              fontSize: 14
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.isLoading? const Expanded(child: ShimmerLoading()):
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.universities.length,
                  itemBuilder: (context, index) {
                    final university = controller.universities[index];
                    return ListTile(
                      leading: SizedBox(
                        height: 40,
                          width: 40,
                          child: Image.asset('assets/images/university_icon.png'),
                      ),
                      title: Text(
                        university.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(WebViewExample(
                                webUrl: convertToHttps(university.webPages[0]),
                              ));
                            },
                            child: SizedBox(
                              width: 170,
                              child: Text(
                                university.webPages[0],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () async{
                              await Clipboard.setData(ClipboardData(text: university.webPages[0]));
                              SnackBarMessage.snackBarMessage("Text Copied!");
                            },
                            child: const Icon(
                              Icons.copy_rounded,
                              size: 14,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  String convertToHttps(String url) {
    if (url.startsWith('http://')) {
      return 'https://' + url.substring(7);
    }
    return url; // If it's already using https or has a different format
  }
}
