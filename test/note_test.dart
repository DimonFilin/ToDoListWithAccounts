import 'package:flutter_test/flutter_test.dart';

import 'package:to_do_list_for_flutter_krainet_vacancy/model/notes_model.dart'; // Замените на путь к вашему файлу с классом Note

void main() {
  group('Note', () {
    test('parseTimeString should correctly parse time string to DateTime', () {
      final note = Note('1', 'Title', '2023:10:05:14:30', 'Subtitle', false, '2023:10:05:14:30');
      final parsedTime = note.parseTimeString('2023:10:05:14:30');
      expect(parsedTime, DateTime(2023, 10, 5, 14, 30));
    });

    test('getTimeRemaining should return correct time remaining', () {
      final note = Note('1', 'Title', '2023:10:05:14:30', 'Subtitle', false, '2023:10:05:14:30');

      // Тест для будущего времени
      final futureTime = DateTime.now().add(Duration(days: 1, hours: 2, minutes: 30));
      final futureTimeString = '${futureTime.year}:${futureTime.month}:${futureTime.day}:${futureTime.hour}:${futureTime.minute}';
      expect(note.getTimeRemaining(futureTimeString), '1d:2h:29m');

      // Тест для времени в прошлом
      final pastTime = DateTime.now().subtract(Duration(days: 1));
      final pastTimeString = '${pastTime.year}:${pastTime.month}:${pastTime.day}:${pastTime.hour}:${pastTime.minute}';
      expect(note.getTimeRemaining(pastTimeString), 'Просрочено');

      // Тест для времени в текущем часе
      final currentHourTime = DateTime.now().add(Duration(minutes: 30));
      final currentHourTimeString = '${currentHourTime.year}:${currentHourTime.month}:${currentHourTime.day}:${currentHourTime.hour}:${currentHourTime.minute}';
      expect(note.getTimeRemaining(currentHourTimeString), '29m');
    });
  });
}