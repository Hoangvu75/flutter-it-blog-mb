import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:rxdart/rxdart.dart';

import '../../../core/config/get_it.dart';
import '../../../core/extensions/context.extension.dart';
import '../../../core/ui/color.ui.dart';
import '../../../core/ui/text.ui.dart';
import '../../../domain/repository/profile.repository.dart';
import '../../../domain/requests/create_profile.request.dart';
import '../../../infrastructure/routing/app_pages.dart';
import '../../../infrastructure/state/is_focus_sign_form.state.dart';
import '../../widgets/green_button.dart';
import '../../widgets/underline_text_field.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final pageController = PageController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final genderSubject = BehaviorSubject<String?>.seeded(null);
  final dobController = TextEditingController();
  DateTime? dob;
  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final addressFocusNode = FocusNode();

  @override
  void initState() {
    firstNameFocusNode.addListener(
      () => focusNodeListener(firstNameFocusNode.hasFocus),
    );
    lastNameFocusNode.addListener(
      () => focusNodeListener(lastNameFocusNode.hasFocus),
    );
    phoneFocusNode.addListener(
      () => focusNodeListener(phoneFocusNode.hasFocus),
    );
    addressFocusNode.addListener(
      () => focusNodeListener(addressFocusNode.hasFocus),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 181,
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                children: [
                  UnderlineTextField(
                    controller: firstNameController,
                    focusNode: firstNameFocusNode,
                    hint: "First name",
                  ),
                  const SizedBox(height: 12),
                  UnderlineTextField(
                    controller: lastNameController,
                    focusNode: lastNameFocusNode,
                    hint: "Last name",
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Builder(builder: (context) {
                      final focusNode = FocusNode();
                      focusNode.addListener(() async {
                        if (focusNode.hasFocus) {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime(2000),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2010),
                            builder: (context, child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: colorGreen,
                                    onPrimary: colorSecondary,
                                    surface: colorSecondary,
                                    onSurface: colorPrimary,
                                  ),
                                  dialogBackgroundColor: colorSecondary,
                                ),
                                child: child!,
                              );
                            },
                          );
                          focusNode.unfocus();
                          dobController.text =
                              DateFormat('dd/MM/yyyy').format(date!);
                          dob = date;
                        }
                      });
                      return TextFormField(
                        controller: dobController,
                        focusNode: focusNode,
                        style: textLargeBody,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          isDense: true,
                          hintText: "Date of birth",
                          hintStyle:
                              textLargeBody.copyWith(color: colorGreyText),
                          focusColor: colorPrimary,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: colorPrimary),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: colorTransparent,
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  UnderlineTextField(
                    controller: phoneController,
                    focusNode: phoneFocusNode,
                    hint: "Phone number",
                  ),
                  const SizedBox(height: 12),
                  UnderlineTextField(
                    controller: addressController,
                    focusNode: addressFocusNode,
                    hint: "Address",
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        StreamBuilder<String?>(
                          stream: genderSubject.stream,
                          builder: (context, snapshot) =>
                              DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              isDense: true,
                              focusColor: colorPrimary,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: colorPrimary),
                              ),
                            ),
                            isExpanded: true,
                            icon: const SizedBox.shrink(),
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'MALE',
                                child: Center(
                                  child: Text(
                                    "Male",
                                    style: textLargeBody,
                                  ),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'FEMALE',
                                child: Center(
                                  child: Text(
                                    "Female",
                                    style: textLargeBody,
                                  ),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'OTHER',
                                child: Center(
                                  child: Text(
                                    "Other",
                                    style: textLargeBody,
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              genderSubject.add(value);
                            },
                            value: genderSubject.value,
                          ),
                        ),
                        const Positioned(
                          right: 0,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: colorGreyText,
                            size: 24,
                          ),
                        ),
                        StreamBuilder<String?>(
                            stream: genderSubject.stream,
                            builder: (context, snapshot) =>
                                genderSubject.value == null
                                    ? Text(
                                        "Gender",
                                        style: textLargeBody.copyWith(
                                            color: colorGreyText),
                                      )
                                    : const SizedBox.shrink()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        GreenButton(
          title: "Next",
          onTap: () async {
            if (pageController.page == 0) {
              var validation = onValidate_0(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
              );
              if (validation != null) {
                EasyLoading.showError(validation);
                return;
              }
              pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            } else {
              var validation = onValidate_1(
                gender: genderSubject.value?.toLowerCase(),
                dateOfBirth: dob?.millisecondsSinceEpoch.toString(),
                phone: phoneController.text,
                address: addressController.text,
              );
              if (validation != null) {
                EasyLoading.showError(validation);
                return;
              }
              await createProfile();
            }
          },
        )
      ],
    );
  }

  void focusNodeListener(bool hasFocus) {
    context.provider
        .read(isFocusSignFormStateProvider.notifier)
        .setFocus(hasFocus);
  }

  Future<void> createProfile() async {
    try {
      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final phone = phoneController.text;
      final address = addressController.text;
      final gender = genderSubject.value?.toLowerCase() ?? "other";
      final dateOfBirth = dob?.millisecondsSinceEpoch ?? 0;
      final request = CreateProfileRequest(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth,
        phone: phone,
        address: address,
        gender: gender,
      );
      final profileRepository = getIt.get<ProfileRepository>();
      EasyLoading.show();
      final response = await profileRepository.createProfile(request);
      EasyLoading.dismiss();
      if (response.isSuccess()) {
        navContext?.go(Routes.PICK_TOPICS);
      } else {
        EasyLoading.showError(response.error ?? "An error occurred");
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError("An error occurred $e");
    }
  }

  String? onValidate_0({
    required String? firstName,
    required String? lastName,
  }) {
    final firstNameValidation =
        ValidationBuilder().required().build()(firstName);
    if (firstNameValidation != null) return "First name is required";
    final lastNameValidation = ValidationBuilder().required().build()(lastName);
    if (lastNameValidation != null) return "Last name is required";
    return null;
  }

  String? onValidate_1({
    required String? gender,
    required String? dateOfBirth,
    required String? phone,
    required String? address,
  }) {
    final genderValidation = ValidationBuilder().required().build()(gender);
    if (genderValidation != null) return "Gender is required";
    final dateOfBirthValidation =
        ValidationBuilder().required().build()(dateOfBirth);
    if (dateOfBirthValidation != null) return "Date of birth is required";
    final phoneValidation =
        ValidationBuilder().required().phone().build()(phone);
    if (phoneValidation != null) return "Phone number is invalid";
    final addressValidation = ValidationBuilder().required().build()(address);
    if (addressValidation != null) return "Address is required";
    return null;
  }
}
