import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:youapp/profile/bloc/profile_bloc.dart';
import 'package:youapp/profile/request/profile_request.dart';
import 'package:youapp/profile/response/profile_response.dart';
import 'package:youapp/util/app_color.dart';
import 'package:youapp/util/custom_app_bar.dart';
import 'package:youapp/widgets/background.dart';

class UpdateInterestWidget extends StatefulWidget {
  final ProfileResponse profileResponse;
  const UpdateInterestWidget({super.key, required this.profileResponse});

  @override
  State<UpdateInterestWidget> createState() => _UpdateInterestWidgetState();
}

class _UpdateInterestWidgetState extends State<UpdateInterestWidget> {
  late double _distanceToField;
  final StringTagController _stringTagController = StringTagController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    _stringTagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        appTitle: '',
        back: (BuildContext context) {
          Navigator.pop(context);
        },
        onPressed: () {},
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProfileBloc>().add(ProfileCreateEvent(
                  profileRequest: ProfileRequest(
                      name: widget.profileResponse.userData.name,
                      birthday: widget.profileResponse.userData.birthday,
                      height: widget.profileResponse.userData.height,
                      weight: widget.profileResponse.userData.weight,
                      interests: _stringTagController.getTags!)));
            },
            child: const Text(
              'Save',
              style: TextStyle(color: YouAppColor.goldColor),
            ),
          ),
        ],
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 4),
                const Text(
                  'Tell everyone about yourself',
                  style: TextStyle(
                    fontSize: 14,
                    color: YouAppColor.goldColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'What interests you?',
                  style: TextStyle(fontSize: 16, color: YouAppColor.whiteColor),
                ),
                const SizedBox(height: 10),
                TextFieldTags<String>(
                  textfieldTagsController: _stringTagController,
                  initialTags: widget.profileResponse.userData.interests,
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (tag == 'testing') {
                      return 'testing not allowed';
                    }
                    return null;
                  },
                  inputFieldBuilder: (context, inputFieldValues) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: TextField(
                        controller: inputFieldValues.textEditingController,
                        focusNode: inputFieldValues.focusNode,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: const TextStyle(
                          color: YouAppColor.whiteColor,
                          fontSize: 18,
                        ),
                        textInputAction: TextInputAction.done,
                        cursorColor: YouAppColor.whiteColor,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: YouAppColor.whiteColor,
                              width: 3.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: YouAppColor.whiteColor,
                              width: 3.0,
                            ),
                          ),
                          helperText: 'Enter your interest...',
                          helperStyle: const TextStyle(
                            color: YouAppColor.whiteColor,
                          ),
                          hintText: inputFieldValues.tags.isNotEmpty
                              ? ''
                              : "Enter your interest...",
                          errorText: inputFieldValues.error,
                          hintStyle: const TextStyle(
                            color: YouAppColor.whiteColor,
                          ),
                          prefixIconConstraints: BoxConstraints(
                            maxWidth: _distanceToField * 0.74,
                          ),
                          prefixIcon: inputFieldValues.tags.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 8.0,
                                    runSpacing: 10,
                                    children: inputFieldValues.tags
                                        .map((String tagData) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          color: Color.fromRGBO(
                                            255,
                                            255,
                                            255,
                                            0.1,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 4.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                '#$tagData',
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  color: YouAppColor.whiteColor,
                                                ),
                                              ),
                                              onTap: () {},
                                            ),
                                            const SizedBox(width: 4.0),
                                            InkWell(
                                              child: const Icon(
                                                Icons.cancel,
                                                size: 14.0,
                                                color: Color.fromARGB(
                                                  255,
                                                  233,
                                                  233,
                                                  233,
                                                ),
                                              ),
                                              onTap: () {
                                                inputFieldValues
                                                    .onTagDelete(tagData);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : null,
                        ),
                        onSubmitted: (value) {
                          if (value.trim().isEmpty) {
                            return;
                          }

                          if (_stringTagController.getValidator != null) {
                            _stringTagController.setError =
                                _stringTagController.getValidator!(value);
                            if (_stringTagController.getError == null) {
                              setState(() {
                                _stringTagController.addTag(value);
                              });
                            }
                          } else {
                            setState(() {
                              _stringTagController.addTag(value);
                            });
                          }
                          inputFieldValues.textEditingController.clear();
                          inputFieldValues.focusNode.requestFocus();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StringTagController extends TextfieldTagsController<String> {
  @override
  bool? addTag(String tag) {
    bool? isAdded = super.addTag(tag);
    notifyListeners();
    return isAdded;
  }

  @override
  set setError(String? error) {
    super.setError = error;
    getTextEditingController?.clear();
    getFocusNode?.requestFocus();
    notifyListeners();
  }
}
