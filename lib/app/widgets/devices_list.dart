import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_level_flutter/app/device_managment_page/device_managment_view_model.dart';
import 'package:water_level_flutter/services/amplify_services.dart';
import 'package:water_level_flutter/services/datastore_services.dart';
import 'package:water_level_flutter/services/device_management_notifier.dart';

class DevicesList extends ConsumerStatefulWidget {
  const DevicesList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DevicesListState();
}

class _DevicesListState extends ConsumerState<DevicesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ref.watch(deviceManagementViewModelProvider).when(
            data: (data) {
              return Text('$data');
            },
            error: ((error, stackTrace) => Text('$error')),
            loading: () => CircularProgressIndicator()),
      ],
    );
  }
}
