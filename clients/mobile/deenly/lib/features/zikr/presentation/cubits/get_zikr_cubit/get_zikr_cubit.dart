import 'package:deenly/features/zikr/usecases/zikr_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'get_zikr_cubit_state.dart';

class GetZikrCubit extends Cubit<GetZikrCubitState> {
  final ZikrUsecase _zikrUsecase;
  GetZikrCubit(this._zikrUsecase) : super(GetZikrCubitInitialState());

  void getZikr(int id) {
    _zikrUsecase.getZirk(id);
  }
}
