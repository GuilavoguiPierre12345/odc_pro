import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';

Widget customTimePicker(
    {required BuildContext context, required Function setState}) {
  TimeOfDay selectedTime = TimeOfDay.now(); // heure courant du telephone

  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${selectedTime.hour} : ${selectedTime.minute}"),
        GFButton(
            type: GFButtonType.outline,
            onPressed: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: selectedTime!,
              );
              if (timeOfDay != null) {
                selectedTime = timeOfDay;
                print(selectedTime);
              }
              setState(() => {});
            },
            child: Text("Date time"))
      ],
    ),
  );
}
// Widget datePickerInput(
//     {String? typeAction,
//     String? defaultValue,
//     required String inputName,
//     required String inputLabel,
//     IconData? prefixIcon}) {
//   return Padding(
//     padding: const EdgeInsets.all(4.0),
//     child: FormBuilderDateTimePicker(
//       timePickerInitialEntryMode: TimePickerEntryMode.dialOnly,
//       autovalidateMode: AutovalidateMode.always,
//       name: inputName,
//       initialDate: DateTime.now(),
//       decoration: InputDecoration(
//         prefixIcon: Icon(prefixIcon),
//         prefixIconColor: Colors.black,
//         labelText: inputLabel,
//         labelStyle: const TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
//       ),
//     ),
//   );
// }
