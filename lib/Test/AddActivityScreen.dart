import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:guide_app/Test/modele/HttpAgancy.dart';
import 'package:guide_app/Test/modele/HttpPlaning.dart';
import 'package:guide_app/Test/modele/agance.dart';
import 'package:guide_app/Test/modele/planningmainModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';


import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:async/async.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  _AddActivityScreenState createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  final _formKey = GlobalKey<FormState>();
  final String _agencyId = '822fe532-6138-43ea-8f61-9ce209247029';
  final String _activityTemplateId = 'a901463c-b73c-4267-b839-fa9a8d1a621a';
  final String _logo =
      '277771965_712318766460223_6468090819953743613_ndf0761ff-f8fc-4296-8c75-1a613d18703f.jpg';
  final String _touristGuideId = 'd771dd42-7c3b-42bb-95b7-fcb64c899f4d';
  String planningId = '996a8585-31d2-4174-911e-d0bb93b2a3f9';
  String _currency = '';
  String _reference = '';
  final String _departureDate = '';
  final String _departureNote = '';
  final String _returnDate = '';
  final String _returnNote = '';
  final bool _confirmed = true;
  double _adultPrice = 0.0;
  double _childPrice = 0.0;
  double _babyPrice = 0.0;
  int _placesCount = 0;
  DateTime _selectedDateTime = DateTime.now();
  DateTime _selectedDepartureDate = DateTime.now();
  final storage = const FlutterSecureStorage();
  final httpHandlerPlanning = HTTPHandlerplaning();
  final httpHandlerAgancy = HTTPHandlerAgancy();
  PlanningMainModel? selectedPlanning = PlanningMainModel();
  List<PlanningMainModel>? planning;
  Agency? selectedAgancy = Agency();
  List<Agency>? agancy;
  String token = "";
  bool circular = false;
  String filePath = '';

  ImageProvider? image;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadDataplanning();
    _loadDataAgancy();
  }
  // Future<void> pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     print('File picked: ${file.name}');
  //     String imagePath = file.path!;
  //     setState(() {
  //       image = FileImage(File(imagePath));
  //     });
  //   } else {
  //     // User canceled the picker
  //     print('User canceled the picker');
  //   }
  // }
  void _loadDataplanning() async {
    setState(() {
      planning = []; // initialize the list to an empty list
    });
    final data = await httpHandlerPlanning.fetchData("/api/plannings");
    setState(() {
      planning = data.cast<PlanningMainModel>();
      selectedPlanning = data.first;
      isLoading = false;
    });
  }

  void _loadDataAgancy() async {
    setState(() {
      agancy = []; // initialize the list to an empty list
    });
    final data = await httpHandlerAgancy.fetchData("agencies");
    setState(() {
      agancy = data.cast<Agency>();
      selectedAgancy = data.first;
      isLoading = false;
    });
  }

  Future<void> _selectDepartureDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDepartureDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDepartureDate),
      );
      if (time != null) {
        setState(() {
          _selectedDepartureDate = DateTime(
            picked.year,
            picked.month,
            picked.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> uploadFile(File file) async {
    // Get the access token
    String? token = await storage.read(key: "access_token");

    // Create the multipart request
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://192.168.1.23:3000/api/activities/upload/68ea8686-2ac7-4465-a986-aecfb643d372'));

    // Set the authorization header
    request.headers.addAll({'Authorization': 'Bearer $token'});

    // Add the file to the request
    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: path.basename(file.path));
    request.files.add(multipartFile);

    // Send the request
    var response = await request.send();

    // Check the response status code
    if (response.statusCode == 200) {
      print('File uploaded successfully!');
    } else {
      print('Error uploading file: ${response.statusCode}');
    }
  }

  // Future<void> pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     print('File picked: ${file.name}');
  //     String filePath = file.path!;
  //     setState(() {
  //       image = FileImage(File(filePath));
  //     });
  //     await uploadFile(File(filePath));
  //   } else {
  //     // User canceled the picker
  //     print('User canceled the picker');
  //   }
  // }
  Future<void> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (PlatformFile file in result.files) {
        print('File picked: ${file.name}');
        String filePath = file.path!;
        setState(() {
          image = FileImage(File(filePath));
        });
        await uploadFile(File(filePath));
      }
    } else {
      // User canceled the picker
      print('User canceled the picker');
    }
  }

  Future<void> _submitForm() async {
    try {
      token = (await storage.read(key: "access_token"))!;
      final response = await http.post(
        Uri.parse('http://192.168.1.23:3000/api/activities/'),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'agencyId': '822fe532-6138-43ea-8f61-9ce209247029',
          'activityTemplateId': 'a901463c-b73c-4267-b839-fa9a8d1a621a',
          'logo':
              '277771965_712318766460223_6468090819953743613_ndf0761ff-f8fc-4296-8c75-1a613d18703f.jpg',
          'touristGuideId': 'd771dd42-7c3b-42bb-95b7-fcb64c899f4d',
          'departureDate': _selectedDepartureDate.toIso8601String(),
          'departureNote': _departureNote,
          'returnDate': _selectedDateTime.toIso8601String(),
          'returnNote': _returnNote,
          'confirmed': true,
          'adultPrice': _adultPrice,
          'childPrice': _childPrice,
          'babyPrice': _babyPrice,
          'placesCount': _placesCount,
          'reference': _reference,
          "planningId": selectedPlanning!.id
        }),
      );

      if (response.statusCode == 201) {
        // Activity created successfully
        print('Activity created successfully!');
        // Close the AddActivity page and navigate back to the previous page
        Navigator.pop(context);
      } else {
        // Error creating activity
        print('Error creating activity: ${response.statusCode}');
      }
    } catch (error) {
      print('API error: $error');
    }
  }

  Future<void> createActivity(newActivity) async {
    try {
      token = (await storage.read(key: "access_token"))!;
      const url = 'http://localhost:3000/api/activities/';

      final headers = {
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'agencyId': newActivity.agencyId,
        'activityTemplateId': newActivity.activityTemplateId,
        'logo': newActivity.logo,
        'touristGuideId': newActivity.touristGuideId,
        'departureDate': newActivity.departureDate.toIso8601String(),
        'departureNote': newActivity.departureNote,
        'returnDate': newActivity.returnDate.toIso8601String(),
        'returnNote': newActivity.returnNote,
        'confirmed': newActivity.confirmed,
        'adultPrice': newActivity.adultPrice,
        'childPrice': newActivity.childPrice,
        'babyPrice': newActivity.babyPrice,
        'placesCount': newActivity.placesCount,
      });

      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        // Activity created successfully
        print('Activity created successfully!');
      } else {
        // Error creating activity
        print('Error creating activity: ${response.statusCode}');
      }
    } catch (error) {
      print('API error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return Center(child: CircularProgressIndicator());
    // } else {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Agency ID'),
              //   onChanged: (value) {
              //     setState(() {
              //       _agencyId = value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Activity Template ID'),
              //   onChanged: (value) {
              //     setState(() {
              //       _activityTemplateId = value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Tourist Guide ID'),
              //   onChanged: (value) {
              //     setState(() {
              //       _touristGuideId = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 32),
              Container(
                child: Row(
                  children: [
                    DropdownButton<PlanningMainModel>(
                      value: selectedPlanning,
                      items: planning!.map((p) {
                        return DropdownMenuItem<PlanningMainModel>(
                          value: p,
                          child: Text(p.name ?? 'h'),
                        );
                      }).toList(),
                      onChanged: (PlanningMainModel? newValue) {
                        setState(() {
                          selectedPlanning = newValue!;
                          print(selectedPlanning!.id);
                        });
                      },
                      style: const TextStyle(
                        color: Color.fromARGB(255, 52, 3, 201),
                        fontSize: 16.0,
                      ),
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: const Color.fromARGB(255, 158, 158, 158),
                    ),
                    const SizedBox(width: 32),
                    DropdownButton<Agency>(
                      value: selectedAgancy,
                      items: agancy!.map((p) {
                        return DropdownMenuItem<Agency>(
                          value: p,
                          child: Text(p.name ?? 'h'),
                        );
                      }).toList(),
                      onChanged: (Agency? newValue) {
                        setState(() {
                          selectedAgancy = newValue!;
                          print(selectedAgancy!.id);
                        });
                      },
                      style: const TextStyle(
                        color: Color.fromARGB(255, 52, 3, 201),
                        fontSize: 16.0,
                      ),
                      dropdownColor: Colors.white,
                      iconEnabledColor: Colors.black,
                      iconDisabledColor: const Color.fromARGB(255, 158, 158, 158),
                    ),
                  ],
                ),
              ),
              Center(
                child: image != null ? Image(image: image!) : const Text("text "),
              ),
              ElevatedButton(
                onPressed: pickFile,
                child: const Text('Select File'),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reference'),
                onChanged: (value) {
                  setState(() {
                    _reference = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Currency'),
                onChanged: (value) {
                  setState(() {
                    _currency = value;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Logo'),
              //   onChanged: (value) {
              //     setState(() {
              //       _logo = value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Departure Date'),
              //   onChanged: (value) {
              //     setState(() {
              //       _departureDate = value;
              //     });
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Departure Date'),
                onTap: _selectDepartureDate,
                controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd HH:mm')
                        .format(_selectedDepartureDate)),
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Return Date'),
              //   onChanged: (value) {
              //     setState(() {
              //       _returnDate = value;
              //     });
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Return Date'),
                onTap: () => _selectDateTime(context),
                controller: TextEditingController(
                  text:
                      DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime),
// DateFormat.yMMMMEEEEd()
//                       .add_Hm()
//                       .format(_selectedDateTime),
                ),
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Return Note'),
              //   onChanged: (value) {
              //     setState(() {
              //       _returnNote = value;
              //     });
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Confirmed'),
              //   onChanged: (value) {
              //     setState(() {
              //       _confirmed = value as bool;
              //     });
              //   },
              // ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Adult Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _adultPrice = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Child Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _childPrice = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Baby Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _babyPrice = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Places Count'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _placesCount = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  // // Save the form data into a newActivity object
                  // Map<String, dynamic> newActivity = {
                  //   'agencyId': '822fe532-6138-43ea-8f61-9ce209247029',
                  //   'activityTemplateId':
                  //       'a901463c-b73c-4267-b839-fa9a8d1a621a',
                  //   'logo': _logo,
                  //   'touristGuideId': 'd771dd42-7c3b-42bb-95b7-fcb64c899f4d',
                  //   'departureDate':_selectedDepartureDate ,
                  //   'departureNote': _departureNote,
                  //   'returnDate': _selectedDateTime,
                  //   'returnNote': _returnNote,
                  //   'confirmed': true,
                  //   'adultPrice': _adultPrice,
                  //   'childPrice': _childPrice,
                  //   'babyPrice': _babyPrice,
                  //   'placesCount': _placesCount,
                  //   'reference': _reference,
                  // };

                  // // Send the new activity data to the server
                  // createActivity(newActivity);
                  _submitForm();
                  // }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
// }
