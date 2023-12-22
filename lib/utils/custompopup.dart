import 'package:flutter/material.dart';
import 'package:movie_app_flutter/utils/custombutton.dart';
import 'package:movie_app_flutter/utils/textfield.dart';

class CustomPopUpWidget extends StatelessWidget {
  const CustomPopUpWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) {
    TextEditingController _typeController = TextEditingController();
    String? _typeSelectedValue;
    String? typeSelectedValue;
    TextEditingController actionsController = TextEditingController();
    TextEditingController responsibleController = TextEditingController();
    TextEditingController employeeCodeController = TextEditingController();
    TextEditingController closedDateController = TextEditingController();
    List<String> type = ['Corrective', 'Preventive'];
    return Dialog(
      child: SizedBox(
        height: 500,
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add data',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField(
                  value: typeSelectedValue,
                  items: type
                      .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                      .toList(),
                  onChanged: (v) {
                    _typeSelectedValue = v;
                    _typeController.text = v!;
                  },
                  decoration: InputDecoration(
                      hintText: "(demo)",
                      labelText: "Potential Rate",
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 138, 138, 138)),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 162, 163, 164),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 162, 163, 164),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      )),
                ),
                textfieledCustom(
                    '', actionsController, TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                textfieledCustom('Responsible', responsibleController,
                    TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                textfieledCustom('Employee Code', employeeCodeController,
                    TextInputType.emailAddress),
                const SizedBox(
                  height: 10,
                ),
                textfieledCustom('Closed Date', closedDateController,
                    TextInputType.emailAddress),
                const SizedBox(
                  height: 20,
                ),
                custombotton('Add', () {}, MediaQuery.of(context).size.width)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
