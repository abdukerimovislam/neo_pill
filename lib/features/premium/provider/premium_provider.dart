import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart'; // Нужен для PlatformException
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const _entitlementId = 'pro';

class PremiumNotifier extends StateNotifier<bool> {
  PremiumNotifier() : super(false) {
    _refreshStatus();
  }

  Future<void> _refreshStatus() async {
    if (!Platform.isIOS) return;

    try {
      // SDK уже инициализирован в main.dart, поэтому просто берем статус
      CustomerInfo customerInfo = await Purchases.getCustomerInfo();
      _updateStatus(customerInfo);

      // Слушаем изменения (если юзер купит с другого устройства)
      Purchases.addCustomerInfoUpdateListener((info) => _updateStatus(info));
    } catch (e) {
      debugPrint("Premium Status Error: $e");
    }
  }

  void _updateStatus(CustomerInfo info) {
    state = info.entitlements.all[_entitlementId]?.isActive ?? false;
  }

  Future<bool> purchasePro() async {
    if (!Platform.isIOS) return false;
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null && offerings.current!.annual != null) {
        PurchaseResult result = await Purchases.purchasePackage(offerings.current!.annual!);
        _updateStatus(result.customerInfo);
        return state;
      }
    } on PlatformException catch (e) {
      // Изящно обрабатываем отмену покупки (userCancelled: true)
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint("Purchase Error: $e");
      } else {
        debugPrint("Покупка отменена пользователем.");
      }
    } catch (e) {
      debugPrint("Unknown Purchase Error: $e");
    }
    return false;
  }

  Future<void> restore() async {
    if (!Platform.isIOS) return;
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();
      _updateStatus(customerInfo);
    } catch (e) {
      debugPrint("Restore Error: $e");
    }
  }
}

final premiumProvider = StateNotifierProvider<PremiumNotifier, bool>((ref) => PremiumNotifier());