import 'package:red_squirrel/services/mark_dao.dart';
import 'package:red_squirrel/utils/constants/classes.dart';

Future<List<Mark>> getMarks() async {
  List<int> chapters = [2, 4, 5, 6];
  return Future.wait(List.generate(chapters.length, (i) async {
    return await MarkDao.getChapterMark(chapters[i]);
  }));
}
