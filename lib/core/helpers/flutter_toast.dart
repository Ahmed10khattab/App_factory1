import 'package:appfactorytest/core/thems/colors.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

import '../widgets/custom_texts.dart';

class ToastManager{
  
  static void showWarningToast(String message,context,String description) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      // style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text16(
        text: message,
        textColor: Colors.black,
        weight: FontWeight.w600,
      ),
      description: Text14(
        text: description,
        textColor: Colors.black,
        weight: FontWeight.w500,
      ),
      icon:Icon(Icons.warning),
      alignment: Alignment.topCenter,
      direction: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 500),
      primaryColor: const Color(0xFFC99C00),
      backgroundColor:const Color(0xffffe78a),
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
  static void showSuccessToast(String message,context,String description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
     //style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text16(
        text: message,
        textColor: Colors.white,
        weight: FontWeight.w600,
      ),
      description: Text14(
        text: description,
        textColor: Colors.white,
        weight: FontWeight.w500,
      ),
      icon: Icon(Icons.done),
      alignment: Alignment.topCenter,
      direction: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 500),
      primaryColor:AppColors.blue ,
      backgroundColor:AppColors.blue ,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
  static void showErrorToast(String message,context,String description) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
   //  style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text16(
        text: message,
        textColor: Colors.black,
        weight: FontWeight.w600,
      ),
      description: Text14(
        text: description,
        textColor: Colors.black,
        weight: FontWeight.w500,
      ),
      icon: Icon(Icons.error),
      alignment: Alignment.topCenter,
      direction: TextDirection.rtl,
      animationDuration: const Duration(milliseconds: 500),
      primaryColor: Colors.red,
      backgroundColor:const Color(0xFFFFA1A1),
      foregroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      borderRadius: BorderRadius.circular(8),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.always,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => print('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            print('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            print('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            print('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
}

