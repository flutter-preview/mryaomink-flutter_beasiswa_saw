import 'package:flutter/material.dart';

class BeasiswaCalculator extends StatefulWidget {
  const BeasiswaCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BeasiswaCalculatorState createState() => _BeasiswaCalculatorState();
}

class _BeasiswaCalculatorState extends State<BeasiswaCalculator> {
  List<Candidate> candidates = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController prestasiController = TextEditingController();
  final TextEditingController ekstrakurikulerController =
      TextEditingController();
  final TextEditingController keuanganController = TextEditingController();

  void calculateScore() {
    String name = nameController.text;
    double prestasi = double.parse(prestasiController.text);
    double ekstrakurikuler = double.parse(ekstrakurikulerController.text);
    double keuangan = double.parse(keuanganController.text);

    double maxPrestasi = 90.0;
    double maxEkstrakurikuler = 9.0;
    double maxKeuangan = 700000.0;

    double normalizedPrestasi = prestasi / maxPrestasi;
    double normalizedEkstrakurikuler = ekstrakurikuler / maxEkstrakurikuler;
    double normalizedKeuangan = keuangan / maxKeuangan;

    double finalScore = (0.4 * normalizedPrestasi) +
        (0.3 * normalizedEkstrakurikuler) +
        (0.3 * normalizedKeuangan);

    setState(() {
      candidates.add(
          Candidate(name, prestasi, ekstrakurikuler, keuangan, finalScore));
    });

    nameController.clear();
    prestasiController.clear();
    ekstrakurikulerController.clear();
    keuanganController.clear();
  }

  String getBeasiswaStatus(double finalScore) {
    if (finalScore >= 0.5) {
      return 'Berhak';
    } else {
      return 'Tidak Berhak';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Program Calon Penerima Beasiswa By Yaomink',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Masukkan Data Calon Penerima Beasiswa',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              flex: 4,
              child: Form(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nama',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: prestasiController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Prestasi (0-100)',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: ekstrakurikulerController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Ekstrakurikuler (0-10)',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: keuanganController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Keuangan (0-1000000)',
                      ),
                    ),
                  ],
                ),
              )),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: calculateScore,
              child: const Text('Hitung Nilai'),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Daftar Calon Penerima Beasiswa:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: candidates.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Calon Penerima ${index + 1}'),
                    subtitle: Text(
                        'Nama: ${candidates[index].name}\nStatus: ${getBeasiswaStatus(candidates[index].finalScore)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Candidate {
  String name;
  double prestasi;
  double ekstrakurikuler;
  double keuangan;
  double finalScore;

  Candidate(this.name, this.prestasi, this.ekstrakurikuler, this.keuangan,
      this.finalScore);
}
