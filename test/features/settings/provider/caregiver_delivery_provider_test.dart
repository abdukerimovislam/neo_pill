import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:neo_pill/features/settings/provider/caregiver_delivery_provider.dart';
import 'package:neo_pill/features/settings/provider/settings_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test(
    'caregiver delivery outbox queues and deduplicates recent alerts',
    () async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      final container = ProviderContainer(
        overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      );
      addTearDown(container.dispose);

      await container
          .read(caregiverDeliveryProvider.notifier)
          .queueAlert(
            caregiverName: 'Anna',
            message: 'Alert body',
            itemCount: 2,
          );
      await container
          .read(caregiverDeliveryProvider.notifier)
          .queueAlert(
            caregiverName: 'Anna',
            message: 'Alert body',
            itemCount: 2,
          );

      final state = container.read(caregiverDeliveryProvider);
      expect(state.shareCode, startsWith('NP-'));
      expect(state.pendingCount, 1);
      expect(state.outbox.single.caregiverName, 'Anna');
    },
  );
}
