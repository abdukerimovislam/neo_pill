import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppCareContext { myCare, caregiving }

final selectedCareContextProvider = StateProvider<AppCareContext>(
  (ref) => AppCareContext.myCare,
);
