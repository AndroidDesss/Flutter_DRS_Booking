import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoader {
  static OverlayEntry? _overlayEntry;

  static void showLoader(BuildContext context) {
    if (_overlayEntry != null) return;
    final overlay = Overlay.of(context);
    if (overlay == null) {
      return;
    }
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          ModalBarrier(
              color: Colors.black.withOpacity(0.9), dismissible: false),
          Center(
            child: Lottie.asset('assets/loader/loading.json',
                width: 130, height: 130),
          ),
        ],
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  static void hideLoader() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
