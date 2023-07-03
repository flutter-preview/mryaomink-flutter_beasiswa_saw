import 'package:beasiswa_sawmethod/model/siswa.dart';
import 'package:beasiswa_sawmethod/screen/yao_siswa.dart';
import 'package:flutter/material.dart';

class YaoSawMethod extends StatefulWidget {
  final List<Siswa> applicants;
  const YaoSawMethod({super.key, required this.applicants});

  @override
  State<YaoSawMethod> createState() => _YaoSawMethodState();
}

class _YaoSawMethodState extends State<YaoSawMethod> {
  Map<String, double> weight = {
    'Akademik': 0.4,
    'Ekstrakulir': 0.3,
    'Essay': 0.0,
    'Kebutuhan Ekonomi': .1,
  };
  // void _addCalonPenerima() {
  //   setState(() {
  //     widget.applicants.add(
  //       Siswa(),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Aplikasi Calon Penerima Beasiswa"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widget.applicants.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const YaoSiswa()));
                        },
                        title: Text(
                          widget.applicants[index].name ??
                              "Calon Penerima Baru",
                        ),
                        subtitle: Text(widget.applicants[index].major ?? ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
