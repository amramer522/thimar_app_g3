import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_app_g3/features/categories/model.dart';
import 'states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesStates());

  Future<void> getData() async {
    emit(GetCategoriesLoadingState());
    final response = await Dio().get("https://thimar.amr.aait-d.com/api/categories");
    final model = CategoriesData.fromJson(response.data);
    emit(GetCategoriesSuccessState(list: model.list));
  }
}
