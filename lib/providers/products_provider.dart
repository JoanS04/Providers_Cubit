import 'package:http/http.dart' as http;
import 'package:plantilla_login_register/models/products.dart';
import 'package:plantilla_login_register/providers/providers.dart';
import 'package:plantilla_login_register/states/states.dart';
class ProductsProvider extends Cubit<DataState> {
  ProductsProvider() : super(DataState());

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse('https://api-tenda-7058f-default-rtdb.europe-west1.firebasedatabase.app/products.json'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Products> productList =
            data.map((item) => Products.fromMap(item)).toList();

        emit(DataState()..setData(productList));
      } else {
        // emit(ErrorDataState('Error: ${response.statusCode}'));
      }
    } catch (e) {
      // emit(ErrorDataState('Error: $e'));
    }
  }
  
}

