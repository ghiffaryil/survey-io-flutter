import 'package:survey_io/models/survey_design/data/demography_occupation_model.dart';

class ListDemographyOccupation {
  static List<DemographyOccupationModel> getDemographyOccupationList() {
    return [
      DemographyOccupationModel(
          id: 1, scope: "Pelajar SMA/SMK Sederajat", price: 150000),
      DemographyOccupationModel(id: 2, scope: "Mahasiswa Aktif", price: 50000),
      DemographyOccupationModel(
          id: 3, scope: "Bekerja paruh waktu / Part-timer", price: 50000),
      DemographyOccupationModel(
          id: 4, scope: "Bekerja penuh waktu / Full-timer", price: 50000),
      DemographyOccupationModel(id: 5, scope: "Wiraswasta", price: 50000),
      DemographyOccupationModel(
          id: 6, scope: "Tenaga Lepas / Freelancer", price: 50000),
      DemographyOccupationModel(
          id: 7, scope: "Tidak Bekerja / Ibu Rumah Tangga", price: 50000),
      DemographyOccupationModel(
          id: 8,
          scope: "Tidak Bekerja / Sedang Mencari Pekerjaan",
          price: 50000),
      DemographyOccupationModel(
          id: 9,
          scope: "Tidak Bekerja / Penyandang Disabilitas",
          price: 150000),
      DemographyOccupationModel(
          id: 10, scope: "Tidak Bekerja / Pensiunan", price: 150000),
    ];
  }
}
