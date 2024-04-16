import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:octoTravel/models/travel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedTransportation; // Dichiarazione della variabile di stato
  File? test;
  String test2 = "Choose from gallery";
  List<Travel> travelList = [];
  String? where;
  String? how = "CAR";
  DateTime? stDate;
  DateTime? enDate;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    print("start");
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          //_buildTravelItem(screenWidth),
          Expanded(
            child: ListView.builder(
              itemCount: travelList.length,
              itemBuilder: (context, index) {
                print("object $index");
                final travel = travelList[index];
                return _buildTravelItem(screenWidth, travel);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                // Logica per navigare alla pagina Home
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Logica per navigare alla pagina Cerca
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Logica per navigare alla pagina Preferiti
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTravelInfoModal(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildTravelItem(double screenWidth, Travel travel) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Container(
          width: screenWidth * 0.8,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(40),
            ),
            border: Border.all(
              color: Color.fromARGB(255, 255, 255, 255),
              width: 2,
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                  /*child: Image.asset(
                    'assets/images/barcellona.jpg',
                    fit: BoxFit.cover,
                  ),*/
                  child: travel.background != null
                      ? Image.file(
                          File(travel.background!.path),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/barcellona.jpg',
                          fit: BoxFit.cover,
                        ), // O qualsiasi altro widget vuoto o di fallback
                ),
              ),
              Center(
                child: Text(
                  (travel.where ?? '').toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'changaOne',
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File?> _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      //return File(pickedImage.path).path.split('/').last;
      return File(pickedImage.path);
    } else {
      // Nessuna immagine selezionata
      return null;
    }
  }
  /*void _selectImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
    } else {
      // Nessuna immagine selezionata
    }
  }*/

  Future<void> _showTravelInfoModal(BuildContext context) async {
    DateTime? startDate;
    DateTime? endDate;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'TRAVEL INFO',
                      style: TextStyle(
                        color: Colors.blue.shade300,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'WHERE:',
                      style: TextStyle(
                        color: Colors.orange.shade400,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          where = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter location',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'WHEN:',
                      style: TextStyle(
                        color: Colors.orange.shade400,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: startDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                selectableDayPredicate: (DateTime day) {
                                  if (endDate != null) {
                                    return day.isAfter(endDate!
                                            .subtract(Duration(days: 1))) ||
                                        day.isBefore(DateTime.now());
                                  } else {
                                    return true;
                                  }
                                },
                              );
                              if (picked != null) {
                                setState(() {
                                  startDate = picked;
                                  stDate = picked;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  startDate != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(startDate!)
                                      : 'Select start date',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: endDate ??
                                    (startDate ?? DateTime.now())
                                        .add(Duration(days: 1)),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                                selectableDayPredicate: (DateTime day) {
                                  if (startDate != null) {
                                    return day.isBefore(startDate!) ||
                                        day.isAfter(DateTime.now());
                                  } else {
                                    return true;
                                  }
                                },
                              );
                              if (picked != null) {
                                setState(() {
                                  endDate = picked;
                                  enDate = picked;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  endDate != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(endDate!)
                                      : 'Select end date',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'HOW:',
                      style: TextStyle(
                        color: Colors.orange.shade400,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton<String>(
                      value: selectedTransportation ??
                          'CAR', // Utilizza il valore selezionato o 'CAR' come valore predefinito
                      onChanged: (String? value) {
                        setState(() {
                          how = value;
                          selectedTransportation =
                              value; // Aggiorna lo stato con il nuovo valore selezionato
                        });
                      },
                      items: <String>['CAR', 'PLANE', 'TRAIN']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'BACKGROUND:',
                      style: TextStyle(
                        color: Colors.orange.shade400,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        test = await _selectImageFromGallery();
                        //_selectImageFromGallery();
                        if (test != null || test != '') {
                          setState(() {
                            test2 = 'Pic Selected!!';
                          });
                        }
                        /*setState(() {
                          test2 = 'u have a pic';
                        });*/
                        //print(test);
                      },
                      child: Text(
                        test2,
                        //'Choose from Gallery',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 36, 147, 40),
                      ),
                      onPressed: () {
                        print(
                            'Il valore di "where" è: $where, Il valore di "how" è: $how, Il valore di "startDate" è: $stDate, Il valore di "endDate" è: $enDate,, Il valore di "bg" è: $test');
                        Travel travel = Travel(
                            where: where,
                            startDate: stDate,
                            finishDate: enDate,
                            how: how,
                            background: test);
                        //travelList.add(travel);
                        //print(travelList.getRange(0, 1));

                        setState(() {
                          travelList.add(travel);
                        });
                        Navigator.pop(context);
                        test2 = "Choose from gallery";
                        test = null;
                        selectedTransportation = "CAR";
                      },
                      child: Text(
                        'CONFERMA',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
