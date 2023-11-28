import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:plantilla_login_register/providers/states.dart';

class ProductsProvider extends Cubit<DataState> {
  DataCubit() : super(InitialDataState());


  Future<void> fetchData() async {
    emit(LoadingDataState());

    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(LoadedDataState(data));
      } else {
        emit(ErrorDataState('Error en la solicitud: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ErrorDataState('Error: $e'));
    }
  }
}