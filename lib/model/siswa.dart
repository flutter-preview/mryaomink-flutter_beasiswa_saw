class Siswa {
  final String? name;
  final int? age;
  final String? major;
  final double? gpa;
  final Map<String, double>? scores;
  late final double? totalScore;
  late final int? rank;

  Siswa(
      {this.name,
      this.age,
      this.major,
      this.gpa,
      this.scores,
      this.totalScore,
      this.rank});

  // Calculate total score using SAW method
  double calculateTotalScore(
      Map<String, double> scores, Map<String, double> weights) {
    double totalScore = 0.0;
    weights.forEach((criteria, weight) {
      totalScore += scores[criteria]! * weight;
    });
    return totalScore;
  }

// Calculate rank based on total score
  int calculateRank(Siswa applicant, List<Siswa> applicants) {
    List<Siswa> sortedApplicants = applicants
        .where((applicant) => applicant.totalScore != null)
        .toList()
      ..sort((a, b) => b.totalScore!.compareTo(a.totalScore!));
    return sortedApplicants.indexOf(applicant) + 1;
  }

  // Calculate total score and rank
  void calculateScoreAndRank(
      List<Siswa> applicants, Map<String, double> weights) {
    totalScore = calculateTotalScore(scores!, weights);
    rank = calculateRank(this, applicants);
  }
}
