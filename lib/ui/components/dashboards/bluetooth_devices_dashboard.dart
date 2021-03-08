part of 'dashboard.dart';

class BluetoothDevicesDashboard extends StatelessWidget {
  
  final Function onTap;
  final BluetoothDevicesKPI kpi;

  const BluetoothDevicesDashboard({
    @required this.onTap,
    @required this.kpi,
  });

  @override
  Widget build(BuildContext context) {
    return _DashboardBase(
            icon: IconDataTheme.bluetooth,
            iconColor: ColorTheme.bluetoothColor,
            title: 'Bluetooth devices',
            content: kpi,
            onTap: onTap,
          );
  }

}