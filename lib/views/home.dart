import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_flutter/utils/custombutton.dart';
import 'package:movie_app_flutter/utils/custompopup.dart';
import 'package:movie_app_flutter/utils/description_textfield.dart';
import 'package:movie_app_flutter/utils/textfield.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController dateInputController = TextEditingController();
  final TextEditingController _txtTimeController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController projectController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController descDamageController = TextEditingController();
  TextEditingController injuriesController = TextEditingController();
  TextEditingController immediateCauseController = TextEditingController();
  TextEditingController underlyingCauseController = TextEditingController();
  TimeOfDay? time = const TimeOfDay(hour: 12, minute: 12);
  departmentList? selecteddepartment;
  @override
  void initState() {
    timeinput.text = "";
    super.initState();
  }
TextEditingController _incidentTypeController=TextEditingController();
TextEditingController _severityRateController=TextEditingController();
TextEditingController _potentialRateController=TextEditingController();
 String? _incidentSelectedValue;
 String? _severitySelectedValue;
 String? _potentialSelectedValue;

  Uint8List? _image;
  File? selectedIMage;
  List<String> incidentType = [
    'Near Miss',
    'First Aid Case',
    'Restricted Work',
    'Medically Treated',
    'Lost Time Injury',
    'Fatality',
    'Occupational Illness',
    'Asset Damage',
    'Environmental Damage',
    'Traffic Accident',
    'Roll Over',
    'Other'
  ];
  List<String> severityRate = ['Catastrophic', 'Major', 'Moderate', 'Minor'];
  List<String> potentialRate = [
    'Rare',
    'Unlikely',
    'Possible',
    'Likely',
    'Almost Certain'
  ];
 
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<departmentList>> departmentEntries =
        <DropdownMenuEntry<departmentList>>[];
    for (final departmentList department in departmentList.values) {
      departmentEntries.add(
        DropdownMenuEntry<departmentList>(
          value: department,
          label: department.label,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios_new),
        title: const Text(
          'INCIDENT REPORT',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'REPORT ORIGINATED BY :',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              textfieledCustom(
                  'Project', projectController, TextInputType.emailAddress),
              const SizedBox(
                height: 10,
              ),
              textfieledCustom('Location of incident', locationController,
                  TextInputType.emailAddress),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 55,
                    width: 150,
                    child: TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          labelText: "Date of incident",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 138, 138, 138)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 129, 128, 127))),
                        ),
                        controller: dateInputController,
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            dateInputController.text =
                                DateFormat('dd MM yyyy').format(pickedDate);
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                  SizedBox(
                    height: 55,
                    width: 150,
                    child: TextFormField(
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          labelText: "Time of incident",
                          labelStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 138, 138, 138)),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 129, 128, 127))),
                        ),
                        controller: _txtTimeController,
                        readOnly: true,
                        onTap: () async {
                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: time!);
                          if (newTime != null) {
                            setState(() {
                              time = newTime;
                              _txtTimeController.text = time!.format(context);
                            });
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                value: _incidentSelectedValue,
                items: incidentType
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (v) {
                   setState(() {
          _incidentSelectedValue = v;
          _incidentTypeController.text = v!;
        });
                },
                decoration: InputDecoration(
                    hintText: "(demo)",
                    labelText: "Incident Type",
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
              const SizedBox(
                height: 15,
              ),
              DropdownButtonFormField(
                value: _severitySelectedValue,
                items: severityRate
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (v) {
                  _severitySelectedValue=v;
                  _severityRateController.text=v!;
                },
                decoration: InputDecoration(
                    hintText: "(demo)",
                    labelText: "Severity Rate",
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
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                value: _potentialSelectedValue,
                items: potentialRate
                    .map((e) => DropdownMenuItem(value: e, child: Text('$e')))
                    .toList(),
                onChanged: (v) {
                  _potentialSelectedValue=v;
                  _potentialRateController.text=v!;
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
              const SizedBox(
                height: 15,
              ),
              const Text(
                'DETAILS :',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              descriptionTextField('Description'),
              const SizedBox(
                height: 10,
              ),
              descriptionTextField('Description of Damage'),
              const SizedBox(
                height: 10,
              ),
              textfieledCustom('Number of person injured', injuriesController,
                  TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              descriptionTextField(
                  'Names of injured people and details of injuries'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'The following for low potential incidents',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5,
              ),
              textfieledCustom('Immediate Causes', immediateCauseController,
                  TextInputType.emailAddress),
              const SizedBox(
                height: 10,
              ),
              textfieledCustom('Underlying Causes', underlyingCauseController,
                  TextInputType.emailAddress),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  border: const OutlineInputBorder(
                      // borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 227, 231, 236))),
                  suffixIcon: DropdownMenu<departmentList>(
                    width: 330,
                    //controller: departmentController,
                    label: const Text(
                      "Incident type",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color.fromARGB(255, 156, 164, 171)),
                    ),
                    dropdownMenuEntries: departmentEntries,
                    onSelected: (departmentList? department) {
                      setState(() {
                        selecteddepartment = department;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              SizedBox(
                height: 40,
                child: ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((context, index) {
                      return const Row(
                        children: [
                          Text(
                            'Actions',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 77, 77, 77)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Sl No',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 77, 77, 77)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Corrective and Preventive Actions',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 77, 77, 77)),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Result',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 77, 77, 77)),
                          )
                        ],
                      );
                    })),
              ),
              const Divider(),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'No data',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 138, 138, 138)),
              ),
              const SizedBox(
                height: 10,
              ),
              custombotton('Add Data', () {
                showDialog(
                    context: context,
                    builder: (context) => const CustomPopUpWidget());
              }, 150),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromARGB(255, 162, 163, 164))),
                child: selectedIMage != null
                    ? Image.file(selectedIMage!)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _pickImageFromGallery();
                            },
                            child: const Icon(
                              Icons.upload_file,
                              size: 50,
                              color: Color.fromARGB(255, 138, 138, 138),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Upload image',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 138, 138, 138)),
                          )
                        ],
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              custombotton('Submit', () {}, MediaQuery.of(context).size.width),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    //  Navigator.of(context).pop(); //close the model sheet
  }
}

enum departmentList {
  BALLB("department", "Near Miss"),
  MCA(
    "department",
    "First Aid Case",
  ),
  LLM("department", "Restricted Work"),
  MBA(
    "department",
    "Medically Treated",
  ),
  LIFESCIENCE("department", "Lost Time Injury"),
  MOLICULAR(
    "department",
    "Fatality",
  ),
  MA(
    "department",
    "Occupational Illness",
  ),
  MAE(
    "department",
    "Asset Damage",
  ),
  MAA(
    "department",
    "Environmental Damage",
  );

  const departmentList(this.department, this.label);
  final String department;
  final String label;
}
