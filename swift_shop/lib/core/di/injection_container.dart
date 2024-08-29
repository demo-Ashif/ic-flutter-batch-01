import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/datasources/auth_remote_data_src.dart';
import '../../features/auth/data/repos/auth_repo_impl.dart';
import '../../features/auth/domain/repos/auth_repo.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../app/cache/cache_helper.dart';
import 'package:http/http.dart' as http;

part 'injection_container.main.dart';