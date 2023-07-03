import 'package:flutter/material.dart';

class Criteria {
  final String name;
  final double weight;

  Criteria({required this.name, required this.weight});
}

class ScholarshipCandidate {
  final String name;
  final Map<Criteria, double> criteriaScores;

  ScholarshipCandidate({required this.name, required this.criteriaScores});
}

class BeasiswaSaw extends StatefulWidget {
  const BeasiswaSaw({super.key});

  @override
  State<BeasiswaSaw> createState() => _BeasiswaSawState();
}

class _BeasiswaSawState extends State<BeasiswaSaw> {
  final List<Criteria> criteriaList = [
    Criteria(name: 'Prestasi Akademik', weight: 0.3),
    Criteria(name: 'Aktivitas Ektrakulikuler', weight: 0.2),
    Criteria(name: 'Kondisi Ekonomi', weight: 0.5),
  ];
  final List<ScholarshipCandidate> candidates = [
    ScholarshipCandidate(
      name: 'Yaomink',
      criteriaScores: {
        Criteria(name: 'Prestasi Akademik', weight: 0.6): 60,
        Criteria(name: 'Aktivitas Ektrakulikuler', weight: 0.2): 90,
        Criteria(name: 'Kondisi Ekonomi', weight: 0.5): 3000000,
      },
    ),
    ScholarshipCandidate(
      name: 'Yoga',
      criteriaScores: {
        Criteria(name: 'Prestasi Akademik', weight: 0.3): 80,
        Criteria(name: 'Aktivitas Ektrakulikuler', weight: 0.2): 90,
        Criteria(name: 'Kondisi Ekonomi', weight: 0.5): 3000000,
      },
    ),
    ScholarshipCandidate(
      name: 'Syarif',
      criteriaScores: {
        Criteria(name: 'Prestasi Akademik', weight: 0.3): 90,
        Criteria(name: 'Aktivitas Ektrakulikuler', weight: 0.2): 70,
        Criteria(name: 'Kondisi Ekonomi', weight: 0.5): 4000000,
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scholarship APP"),
        actions: const [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: criteriaList.length,
            itemBuilder: (context, index) {
              final criteria = criteriaList[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Criteria: ${criteria.name}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      for (var candidate in candidates)
                        Row(
                          children: [
                            Expanded(
                                child: Text('Candidate: ${candidate.name}')),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                  'Score: ${candidate.criteriaScores[criteria] ?? 'N/A'}'),
                            ),
                          ],
                        ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          List<ScholarshipCandidate> passedCandidates = [];

                          double maxPreferenceValue = double.negativeInfinity;

                          for (var candidate in candidates) {
                            double? criteriaScore =
                                candidate.criteriaScores[criteria];

                            if (criteriaScore != null) {
                              double preferenceValue =
                                  criteriaScore * criteria.weight;

                              if (preferenceValue > maxPreferenceValue) {
                                maxPreferenceValue = preferenceValue;
                                passedCandidates = [candidate];
                              } else if (preferenceValue ==
                                  maxPreferenceValue) {
                                passedCandidates.add(candidate);
                              }
                            }
                          }

                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Result'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'Passed Candidates for Criteria: ${criteria.name}'),
                                    const SizedBox(height: 8),
                                    for (var passedCandidate
                                        in passedCandidates)
                                      Text(passedCandidate.name),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text('Calculate Preference Value'),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
