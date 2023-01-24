import 'package:admin/components/filteritem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'orders_state.dart';

 
class OrderController extends Cubit<OrderStates> {
  OrderController() : super(InitialState());
  static OrderController get(ctx) => BlocProvider.of(ctx);
  bool allOrders = true;
  bool compeletOrders = false;
  bool uncompeletOrders = false;
  showFilteration(context, Size size) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              content: Container(
                height: size.longestSide * .28,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white70),
                padding: EdgeInsets.symmetric(
                  horizontal: size.shortestSide * .02,
                  vertical: size.longestSide * .02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilterItem(
                      head: "All orders",
                      onTap: () {
                        allOrders = true;
                        compeletOrders = false;
                        uncompeletOrders = false;
                        emit(GetFilterValueState());
                      },
                      size: size,
                    ),
                    FilterItem(
                      head: "Compeleted orders",
                      onTap: () {
                        allOrders = false;
                        compeletOrders = true;
                        uncompeletOrders = false;
                        emit(GetFilterValueState());
                      },
                      size: size,
                    ),
                    FilterItem(
                      head: "Uncompeleted orders",
                      onTap: () {
                        allOrders = false;
                        compeletOrders = false;
                        uncompeletOrders = true;
                        emit(GetFilterValueState());
                      },
                      size: size,
                    ),
                  ],
                ),
              ),
            ));
  }
}
