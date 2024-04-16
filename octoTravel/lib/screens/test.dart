import 'package:flutter/material.dart';

// Definizione della classe Travel
class Travel {
  final String where;
  final DateTime startDate;
  final DateTime finishDate;
  final String how;
  final String background;

  Travel({
    required this.where,
    required this.startDate,
    required this.finishDate,
    required this.how,
    required this.background,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Travel> travelList = []; // Lista dei viaggi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: travelList.length,
              itemBuilder: (context, index) {
                final travel = travelList[index];
                return _buildTravelItem(travel);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulazione di aggiunta di un nuovo viaggio
          final newTravel = Travel(
            where: 'New Destination',
            startDate: DateTime.now(),
            finishDate: DateTime.now().add(Duration(days: 7)),
            how: 'New Transportation',
            background: 'assets/new_destination.jpg',
          );

          // Aggiungi il nuovo viaggio alla lista e forza l'aggiornamento dell'interfaccia utente
          setState(() {
            travelList.add(newTravel);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Metodo per costruire l'elemento di viaggio
  Widget _buildTravelItem(Travel travel) {
    // Costruisci e restituisci l'oggetto visivo dell'interfaccia utente per il singolo elemento di viaggio
    return ListTile(
      title: Text(travel.where),
      subtitle: Text('${travel.startDate} - ${travel.finishDate}'),
      // Altri widget per visualizzare le informazioni del viaggio
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
