import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_flutter/utils/custombutton.dart';
import 'package:movie_app_flutter/utils/custompopup.dart';
import 'package:movie_app_flutter/utils/description_textfield.dart';
import 'package:movie_app_flutter/utils/textfield.dart';
import '../blocs/post_bloc/post_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List data = [];
  int _value = 1;

  getData() async {
    final res = await http.get(
        Uri.parse('http://103.120.178.195/Sang.Ray.Mob.Api/Ray/GetProject'));
    //data = jsonDecode(res.body);
    Map<String, dynamic> data = jsonDecode(res.body);
    //print(data);

    setState(() {});
  }

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

  @override
  void initState() {
    timeinput.text = "";
    super.initState();
  }

  TextEditingController _incidentTypeController = TextEditingController();
  TextEditingController _severityRateController = TextEditingController();
  TextEditingController _potentialRateController = TextEditingController();
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
    getData();
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
              Center(
                child: DropdownButtonFormField(
                    items: data.map((e) {
                      return DropdownMenuItem(
                        child: Text(e['sName']),
                        value: e['iId'],
                      );
                    }).toList(),
                    value: _value,
                    onChanged: (v) {
                      _value = v as int;
                      setState(() {});
                    },
                     decoration: InputDecoration(
                   // hintText: "(demo)",
                    labelText: "Project",
                    labelStyle: const TextStyle(
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
              ),
              // textfieledCustom(
              //     'Project', projectController, TextInputType.emailAddress),
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
                  _severitySelectedValue = v;
                  _severityRateController.text = v!;
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
                  _potentialSelectedValue = v;
                  _potentialRateController.text = v!;
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
              BlocProvider(
                  create: (context) => PostBloc(),
                  child: custombotton('Submit', () async {
                    Map<String, dynamic> body = {
                      "iTransId": 0,
                      "Project": 1,
                      "Location": locationController.text,
                      "Date": dateInputController.text,
                      "Time": timeinput.text,
                      "IncidentType": 1,
                      "Severity_Rate": 1,
                      "Potential_Rate": 1,
                      "Others": "oth1",
                      "IncidentDescription": descriptionController.text,
                      "DamageDescription": descDamageController.text,
                      "No_Injured_Person": injuriesController.text,
                      "DetailsOfPersons": "",
                      "ImmediateCauses": "imm1",
                      "UnderlyingCauses": "undcau",
                      "UserId": 1,
                      "Images": "",
                    };

                    try {
                      var url = Uri.parse(
                          'http://103.120.178.195/Sang.Ray.Mob.Api/Ray/PostIncident');
                      var headers = {
                        'Content-Type': 'multipart/form-data',
                      };

                      var request = http.MultipartRequest("POST", url);
                      request.headers.addAll(headers);

                      if (selectedIMage?.path.isNotEmpty ?? false) {
                        http.MultipartFile multipartFile =
                            await http.MultipartFile.fromPath(
                                "name", selectedIMage?.path ?? "");
                        request.files.add(multipartFile);
                      }
                      request.fields["body"] = jsonEncode(body);

                      var response =
                          await http.Response.fromStream(await request.send());

                      log(response.body.toString());
                      log(response.statusCode.toString());

                      if (response.statusCode == 200) {
                      } else {
                        final errorMessage = response.body;

                        //  emit(CreateFailure(error: errorMessage));
                      }
                    } catch (error) {
                      log('Error: $error');

                      //emit(CreateFailure(error: error.toString()));
                    }
                  }, MediaQuery.of(context).size.width)),
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
