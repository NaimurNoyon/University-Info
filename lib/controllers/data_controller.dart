import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/universities_model.dart';

class DataController extends GetxController{
  String countryName = 'Bangladesh';
  bool isLoading = false;
  bool iconUp = false;

  @override
  void onInit() {
    super.onInit();
    fetchUniversities();
  }

  Future<void> selectCountry(String country)async {
    update();
    countryName = country;
    await fetchUniversities();
  }


  List<UniversityModel> universities = [];

  Future<void> fetchUniversities() async {
    isLoading = true;
    try {
      final response = await http.get(Uri.parse('http://universities.hipolabs.com/search?country=$countryName'));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Data fetched successfully');
        }
        final List<dynamic> responseData = json.decode(response.body);
        universities = responseData.map((json) => UniversityModel.fromJson(json)).toList();
        update();
      } else {
        throw Exception('Failed to load universities');
      }


    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }finally{
      isLoading = false;
      update();
    }
  }

  void setIconDirection(bool bool){
      iconUp = bool;
      update();
  }


  //Limiting industrial ads
  int totalNoOfPressed = 0;

  Future<int> increaseTotalNoOfPressed() async{
    totalNoOfPressed = totalNoOfPressed + 1;
    return totalNoOfPressed;
  }
}