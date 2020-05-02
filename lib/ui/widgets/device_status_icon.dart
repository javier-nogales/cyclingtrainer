import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';


class DeviceStatusIcon<B extends DeviceStateBloc> extends StatelessWidget {

  final IconData icon;

  const DeviceStatusIcon({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, DeviceStateState>(
      bloc: BlocProvider.of<B>(context),
      builder: (context, state) {
        Color color1 = Colors.blueGrey.withOpacity(0.2);
        Color color2 = Colors.white.withOpacity(0.2);
        if (state is DeviceStateUpdateSuccess) {
          if (state.state == DeviceState.notFound) {
            color2 = Colors.red;
          } else if (state.state == DeviceState.connected) {
            color2 = Colors.green;
          } else if (state.state == DeviceState.disconnected) {
            color2 = Colors.brown;
          }
        } 
        return Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: color1,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(
            children: <Widget>[
              if (state is DeviceStateFailure)
              Positioned(
                top: 3,
                left: 3,
                child: FaIcon(
                  FontAwesomeIcons.ban,
                  color: Colors.red[300],
                  size: 15,
                ),
              ),
              Center(
                child: Icon(icon, color: color2, size: 50,),
              ),
            ]
          ),
        );
      },
    );
  }

}
