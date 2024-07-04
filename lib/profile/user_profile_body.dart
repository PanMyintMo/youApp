import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youapp/extension/birth_extension.dart';
import 'package:youapp/profile/bloc/profile_bloc.dart';
import 'package:youapp/profile/request/profile_request.dart';
import 'package:youapp/profile/response/profile_response.dart';
import 'package:youapp/util/app_date_field.dart';
import 'package:youapp/util/app_drop_down_field.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/app_sign.dart';
import 'package:youapp/util/app_textfield.dart';

class UserProfileBody extends StatefulWidget {
  final Function(File? image) callBackImage;
  final ProfileResponse? profileResponse;
  const UserProfileBody(
      {super.key, required this.callBackImage, required this.profileResponse});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  ProfileResponse? profileResponse;
  String displayName = "";
  String birthday = "";
  String horoscope = "";
  String zodiac = "";
  int height = 0;
  int weight = 0;
  String gender = "";

  File? _image;

  final ImagePicker _picker = ImagePicker();

  bool get isFormValid =>
      displayName.isNotEmpty &&
          height != 0 &&
          weight != 0 &&
          birthday.isNotEmpty ||
      gender.isNotEmpty;

  void getDisplayNameFromCallBack(String text) {
    setState(() {
      displayName = text;
    });
  }

  void getBirthdayFromCallBack(String text) {
    setState(() {
      birthday = text;
    });
  }

  void getHoroscopeSign(String text) {
    setState(() {
      horoscope = text;
    });
  }

  void getZodiacSign(String text) {
    setState(() {
      zodiac = text;
    });
  }

  void getHeightFromCallBack(String text) {
    setState(() {
      height = int.parse(text);
    });
  }

  void getWeightFromCallBack(String text) {
    setState(() {
      weight = int.parse(text);
    });
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        saveImage(_image);
        widget.callBackImage(_image);
      });
    }
  }

  void saveImage(File? image) async {
    try {
      final String path = (await getApplicationDocumentsDirectory()).path;

      await File(image!.path).copy('$path/${image.path.split('/').last}');
      //  logger.d('Save image under: $path/${image.path.split('/').last}');
    } catch (e) {
      //   logger.e("Error saving image $e");
    }
  }

  @override
  void initState() {
    displayName = widget.profileResponse?.userData.username ?? "";

    birthday = widget.profileResponse?.userData.birthday ?? "";
    if (birthday.isNotEmpty) {
      horoscope = DateTime.parse(widget.profileResponse!.userData.birthday)
          .getHoroscopeSign();
      zodiac = DateTime.parse(widget.profileResponse!.userData.birthday)
          .getZodiacSign();
    }
    height = widget.profileResponse?.userData.height ?? 0;
    weight = widget.profileResponse?.userData.weight ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('About',
                      style: TextStyle(color: YouAppColor.whiteColor)),
                  TextButton(
                    onPressed: isFormValid
                        ? () {
                            if (widget.profileResponse != null) {
                              context.read<ProfileBloc>().add(
                                  UpdateProfileEvent(
                                      updateProfileRequest: ProfileRequest(
                                          name: displayName,
                                          birthday: birthday,
                                          height: height,
                                          weight: weight,
                                          interests: widget.profileResponse!
                                              .userData.interests)));
                            } else {
                              context.read<ProfileBloc>().add(
                                  ProfileCreateEvent(
                                      profileRequest: ProfileRequest(
                                          name: displayName,
                                          birthday: birthday,
                                          height: height,
                                          weight: weight,
                                          interests: [])));
                            }
                          }
                        : () {
                            EasyLoading.showInfo("You have to fill data!");
                          },
                    child: Text(
                      'Save & Update',
                      style: TextStyle(
                          color: isFormValid
                              ? YouAppColor.goldenColor
                              : Colors.grey.withOpacity(0.2),
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: pickImage,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add,
                          size: 40, color: YouAppColor.goldColor),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('Add image',
                      style: TextStyle(
                          fontSize: 18, color: YouAppColor.whiteColor)),
                ],
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Display name:',
                hint: displayName.isNotEmpty ? displayName : 'Enter name',
                callBackController: getDisplayNameFromCallBack,
              ),
              AppDropDownFiled(
                label: 'Gender:',
                hint: 'Select Gender',
                context: context,
                returnChangeValue: (changeValue) {
                  setState(() {
                    gender = changeValue;
                  });
                },
              ),
              AppDateTextField(
                label: 'Birthday:',
                hint: birthday.isNotEmpty ? birthday : 'DD MM YYYY',
                callBackController: getBirthdayFromCallBack,
                horoscopeSign: getHoroscopeSign,
                zodiacSign: getZodiacSign,
              ),
              AppSign(label: "Horoscope", text: horoscope),
              AppSign(label: "Zodiac", text: zodiac),
              AppTextField(
                label: 'Height:',
                hint: height != 0 ? height.toString() : 'Add height',
                callBackController: getHeightFromCallBack,
              ),
              AppTextField(
                callBackController: getWeightFromCallBack,
                label: 'Weight:',
                hint: weight != 0 ? weight.toString() : 'Add weight',
              ),
            ],
          ),
        );
      }
  //  );
  }
//}
