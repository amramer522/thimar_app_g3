import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar_app_g3/features/slider/model.dart';
import 'package:thimar_app_g3/features/slider/states.dart';

class SliderCubit extends Cubit<SliderStates> {
  SliderCubit() : super(SliderStates());

  Future<void> getData() async {
    emit(GetSliderLoadingState());
    final response = await Dio().get("https://thimar.amr.aait-d.com/api/sliders");
    SliderData model = SliderData.fromJson(response.data);
    emit(GetSliderSuccessState(list: model.list));
  }
}
