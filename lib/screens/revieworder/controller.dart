import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'state.dart';

class ReviewOrderController extends Cubit<ReviewOrderState> {
  final feedbackController = TextEditingController();

  ReviewOrderController() : super(InitialState());
  static ReviewOrderController get(context) => BlocProvider.of(context);
}
