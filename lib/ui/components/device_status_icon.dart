import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/api/device/device.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';
import 'package:trainerapp/ui/theme/color_theme.dart';
import 'package:trainerapp/ui/theme/icon_theme.dart';

class DeviceStatusIcon extends StatelessWidget {

  final DeviceStateBloc bloc;
  final DeviceType type;

   DeviceStatusIcon({
    @required this.bloc,
    @required this.type
  });

  @override
  Widget build(BuildContext context) {
    
  final IconData iconData = _iconDataFrom(type);
  final Color color = _colorFrom(type); 
    return BlocBuilder<DeviceStateBloc, DeviceStateState>(
      bloc: bloc,
      builder: (context, state) {

        if (state is DeviceStateUpdateSuccess) {
          if (state.state == DeviceState.connected) 
            return _FoundStatusIcon(iconData: iconData, color: color);
          else
            return _NotFoundStatusIcon(iconData: iconData, color: color);
        } else {
          return _NotLinkedStatusIcon(iconData: iconData);
        }
            
      }
    );
  }

}

class _FoundStatusIcon extends StatelessWidget {

  final IconData iconData;
  final Color color;

  const _FoundStatusIcon({
    @required this.iconData,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
              child: Icon(
                iconData,
                color: color,
                size: 30,
              ),
              height: 45,
              width: 45,
              margin: EdgeInsets.all(7.5),
              decoration: BoxDecoration(            
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withOpacity(0.2)),
              )
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Icon(
                Icons.done,
                color: ColorTheme.ok,
                size: 15,
              ),
             
            )
          ]
    );
  }
}


class _NotFoundStatusIcon extends StatelessWidget {

  final IconData iconData;
  final Color color;

  const _NotFoundStatusIcon({
    @required this.iconData,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
              child: Icon(
                iconData,
                color: color,
                size: 30,
              ),
              height: 45,
              width: 45,
              margin: EdgeInsets.all(7.5),
              decoration: BoxDecoration(            
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: color.withOpacity(0.2)),
              )
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Icon(
                Icons.close,
                color: ColorTheme.error,
                size: 15,
              ),
             
            )
          ]
    );
  }
}

class _NotLinkedStatusIcon extends StatelessWidget {

  final IconData iconData;
  final Color color = ColorTheme.phantom;

  const _NotLinkedStatusIcon({
    @required this.iconData
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(
        iconData,
        color: color.withOpacity(0.2),
        size: 30,
      ),
      height: 45,
      width: 45,
      decoration: BoxDecoration(            
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        // border: Border.all(color: color.withOpacity(0.1)),
      )
    );
  }
}


IconData _iconDataFrom(DeviceType type) {
  IconData iconData;
  switch (type) {
    case DeviceType.trainer:
      iconData = IconDataTheme.trainerDevice;
      break;
    case DeviceType.heartRate:
      iconData = IconDataTheme.heartRateDevice;
      break;
    case DeviceType.cadence:
      iconData = IconDataTheme.cadenceDevice;
      break;
    case DeviceType.speed:
      iconData = IconDataTheme.speedDevice;
      break;
    default:
      throw Exception('Device type not supported');
  }
  return iconData;
}

Color _colorFrom(DeviceType type) {
  Color iconColor;
  switch (type) {
    case DeviceType.trainer:
      iconColor = ColorTheme.trainerDevice;
      break;
    case DeviceType.heartRate:
      iconColor = ColorTheme.heartRateDevice;
      break;
    case DeviceType.cadence:
      iconColor = ColorTheme.cadenceDevice;
      break;
    case DeviceType.speed:
      iconColor = ColorTheme.speedDevice;
      break;
    default:
      throw Exception('Device type not supported');
  }
  return iconColor;
}