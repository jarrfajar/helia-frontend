import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:helia/app/color/colors.dart';
import 'package:helia/app/models/profile.dart';
import 'package:helia/app/reusable/button.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: ColorSelect.black,
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: ColorSelect.black,
          ),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
        future: controller.getProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          Profile profile = controller.profile.first;

          controller.name.text = profile.name ?? '';
          controller.birthday.text = profile.profiles!.birthday ?? '';
          // controller.gender.value = profile.profiles!.gender ?? 'Gender';
          controller.gender.value = profile.profiles!.gender ?? '';
          controller.job.text = profile.profiles!.job ?? '';
          controller.phone.text = profile.profiles!.phone ?? '';
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // NAME
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: TextFormField(
                  controller: controller.name,
                  decoration: const InputDecoration.collapsed(
                    filled: true,
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    // hintText: profile.name,
                    hintText: 'name',
                  ),
                  onFieldSubmitted: (value) {},
                ),
              ),
              const SizedBox(height: 20.0),

              // BIRTHDAY
              GestureDetector(
                onTap: () => Get.dialog(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: ListView(
                      shrinkWrap: true,
                      children: [
                        SfDateRangePicker(
                          view: DateRangePickerView.month,
                          monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                          selectionColor: ColorSelect.green,
                          initialSelectedDate: DateTime.now(),
                          todayHighlightColor: ColorSelect.green,
                          showNavigationArrow: true,
                          headerStyle: const DateRangePickerHeaderStyle(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          showActionButtons: true,
                          onSubmit: (value) {
                            print(value);
                            Get.back();
                            controller.birthdays.value = controller.dateformat(value.toString());
                          },
                          onCancel: () {
                            controller.datePiceker.selectedDates = null;
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 6, bottom: 6, left: 20, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: TextFormField(
                            readOnly: true,
                            controller: controller.birthday,
                            initialValue: null,
                            decoration: InputDecoration.collapsed(
                              filled: true,
                              fillColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              hintText: controller.birthdays.value == '' ? 'Birthday' : controller.birthdays.value,
                              // hintText: "sas",
                            ),
                            onFieldSubmitted: (value) {},
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.calendar_today_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // GENDER
              Obx(
                () => Container(
                  padding: const EdgeInsets.only(top: 3, bottom: 3, left: 20, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    // hint: Text(gender.toString()),
                    hint: const Text('Gender'),
                    onChanged: (e) {
                      controller.selectGender(e.toString());
                    },
                    value: controller.gender.value == '' ? null : controller.gender.value,
                    items: controller.list.map((e) {
                      // print(e.tipeKamar?.tipeKamar);
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // JOB
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: TextFormField(
                  controller: controller.job,
                  decoration: const InputDecoration.collapsed(
                    filled: true,
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    // hintText: profile.name,
                    hintText: 'Job',
                  ),
                  onFieldSubmitted: (value) {},
                ),
              ),
              const SizedBox(height: 20.0),

              // PHONE
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phone,
                  decoration: const InputDecoration.collapsed(
                    filled: true,
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    // hintText: profile.name,
                    hintText: 'Phone',
                  ),
                  onFieldSubmitted: (value) {},
                ),
              ),
            ],
          );
        },
      ),

      // BUTTON
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => RsButton(
            onPress: () {
              Get.dialog(
                AlertDialog(
                  content: ListView(
                    shrinkWrap: true,
                    children: const [
                      Text("are you sure you want to update your profile"),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSelect.greenSoft,
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: ColorSelect.green,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.updateProfile(
                        name: controller.name.text,
                        birthday: controller.birthdays.value,
                        phone: controller.phone.text,
                        jk: controller.gender.value,
                        job: controller.job.text,
                      ),
                      child: controller.isLoading.isTrue
                          ? const SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 3,
                                color: Colors.white,
                              ),
                            )
                          : const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
            color: ColorSelect.green,
            isLoading: controller.isLoading.isTrue,
            label: 'Update',
          ),
        ),
      ),
    );
  }
}
