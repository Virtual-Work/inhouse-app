class StaffReportModel{
  String period;
  String project;
  String time;
  String text;
  bool status;

  StaffReportModel({this.period, this.project, this.time, this.text, this.status});

}

List<StaffReportModel> getReport() {
  List<StaffReportModel> report = [
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: false),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: true),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: false),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: true),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: false),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: true),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: false),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: true),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: false),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: true),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: false),
    StaffReportModel(period: '12/29/2019', text: 'Am the short text', project: 'Mobile Dev', time: '11:30', status: true),

  ];
  return report;
}