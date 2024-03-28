import 'package:flutter/material.dart';

class Utility{
  static void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (BuildContext builderContext) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                              'Add URL',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              )),
                        ),
                        InkWell(
                          child: Container(
                              margin: const EdgeInsets.only(right: 20),
                              height: 30,
                              child: const Icon(Icons.cancel)),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              disabledForegroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              fixedSize: const Size(double.infinity, 45)),
                          onPressed: () {

                          },
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Save',
                              style:  TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

}