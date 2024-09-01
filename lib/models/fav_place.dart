
import 'package:uuid/uuid.dart';

class FavPlace{
  FavPlace({required this.title}):id=const Uuid().v4();

  final String id;
  final String title;
}