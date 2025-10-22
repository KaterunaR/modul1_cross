import 'dart:async';

class WorkDay {
  String _date;       
  int _patients;
  String _startTime;  

  WorkDay(this._date, this._patients, this._startTime);

  String get date => _date;
  int get patients => _patients;
  String get startTime => _startTime;

  set patients(int value) => _patients = value;
  set startTime(String value) => _startTime = value;
}

class Doctor {
  String _fullName;
  String _specialty;

  Map<String, WorkDay> _schedule = {}; 

  Doctor(this._fullName, this._specialty);

  String get name => _fullName;
  String get specialty => _specialty;
  Map<String, WorkDay> get schedule => _schedule;

  set name(String value) => _fullName = value;
  set specialty(String value) => _specialty = value;

  void addWorkDay(WorkDay day) {
    _schedule[day.date] = day;
  }

  // середня кількість пацієнтів
  int averagePatients() {
    if (_schedule.isEmpty) return 0;
    int total = 0;
    for (var day in _schedule.values) {
      total += day.patients;
    }
    return total ~/ _schedule.length;
  }

  // кількість днів з максимальним навантаженням
  int maxLoadDays() {
    if (_schedule.isEmpty) return 0;

    int maxPatients = 0;
    for (var day in _schedule.values) {
      if (day.patients > maxPatients) {
        maxPatients = day.patients;
      }
    }

    return _schedule.values.where((d) => d.patients == maxPatients).length;
  }

  // дні коли почав приймати після зазначеного часу
  List<String> daysAfterTime(String time) {
    List<String> result = [];

    for (var day in _schedule.values) {
      if (day.startTime.compareTo(time) > 0) {
        result.add(day.date);
      }
    }

    return result;
  }

  // generic метод з Future
  Future<T> fetchData<T>(T Function() constructor) async {
    try {
      await Future.delayed(Duration(seconds: 3));
      return constructor();
    } catch (e) {
      throw Exception('Помилка при створенні об’єкта: $e');
    }
  }

  void getInfo(String timeLimit) {
    print('Середня кількість пацієнтів: ${averagePatients()}');
    print('Кількість днів з максимальним навантаженням: ${maxLoadDays()}');
    print('Дні, коли почав після $timeLimit: ${daysAfterTime(timeLimit)}');
  }
}

void main() async {
  Doctor doc = Doctor('Яворська Ліза Василівна', 'Стоматолог');

  print('Лікаря: ${doc.name}; Спеціальність: ${doc.specialty}');
  doc.addWorkDay(WorkDay('2025-10-20', 10, '09:00'));
  doc.addWorkDay(WorkDay('2025-10-21', 15, '10:00'));
  doc.addWorkDay(WorkDay('2025-10-22', 15, '16:30'));
  doc.addWorkDay(WorkDay('2025-10-23', 5, '14:05'));
  doc.addWorkDay(WorkDay('2025-10-24', 12, '17:00'));

  doc.getInfo('14:00');
  
  print('-------------------------------------------------------');

  Doctor newDoctor = await doc.fetchData(
      () => Doctor('Мельник Михайло Михайлолвич', 'Окуліст'));
  print('Додано нового лікаря через Future: ${newDoctor.name}, ${newDoctor.specialty}');
  newDoctor.addWorkDay(WorkDay('2025-10-20', 2, '09:00'));
  newDoctor.addWorkDay(WorkDay('2025-10-21', 1, '10:00'));
  newDoctor.addWorkDay(WorkDay('2025-10-22', 1, '16:30'));
  newDoctor.addWorkDay(WorkDay('2025-10-23', 5, '14:05'));
  newDoctor.addWorkDay(WorkDay('2025-10-24', 4, '17:00'));

  newDoctor.getInfo('09:00');

}
