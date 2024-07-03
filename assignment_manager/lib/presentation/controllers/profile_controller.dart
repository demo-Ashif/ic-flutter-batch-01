import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/response_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/api_service.dart';
import '../../data/utils/network_const.dart';

class ProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  //for profile image
  XFile? _pickedImage;
  String? _photo;

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage ?? 'Profile update failed! Try again';

  String get profilePhoto => _photo ?? '';

  UserModel? user;

  @override
  void onInit(){
    super.onInit();
    getUserProfile();
  }

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (_pickedImage != null) {
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      _photo = base64Encode(bytes);

      log(_photo!);
    }

    update();
  }

  Future<bool> updateProfile(String name, String email, String mobile) async {
    _inProgress = true;
    update();

    // api call
    Map<String, dynamic> inputParams = {
      "name": name,
      "email": email,
      "mobile": mobile,
    };


    if (_photo != null) {
      inputParams['photo'] = _photo;
    }

    ResponseModel response = await ApiService.postRequest(
      NetworkConst.updateProfile,
      inputParams,
    );

    _inProgress = false;

    if (response.isSuccess) {
      user = UserModel.fromJson(response.responseBody['user']);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }


  ///Getting current user profile
  void getUserProfile() async {

    _inProgress = true;
    update();

    ResponseModel response = await ApiService.getRequest(
      NetworkConst.getUserProfile,
    );

    _inProgress = false;

    if (response.isSuccess) {
      user = UserModel.fromJson(response.responseBody['data']);
      _photo = user?.photo;
      update();
    } else {
      _errorMessage = response.errorMessage;
      update();
    }
  }
}
