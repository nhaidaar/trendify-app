import 'package:appwrite/appwrite.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:fpdart/fpdart.dart';
import 'package:trendify/features/home/domain/repositories/home_repository.dart';
// import 'package:trendify/features/post/data/models/post_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final Client client;
  const HomeRepositoryImpl({required this.client});
}
