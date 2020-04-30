import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trainerapp/api/device/device_package.dart';
import 'package:trainerapp/api/use_cases/device_use_cases.dart';
import 'package:trainerapp/api/use_cases/trainer_device_use_cases.dart';
import 'package:trainerapp/bloc/device_state/bloc.dart';
import 'package:trainerapp/bloc/device_state/device_state_bloc.dart';
import 'package:trainerapp/injection_container.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DevicesStatus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TrainerDeviceStateBloc>(
            create: (BuildContext context) {
              TrainerDeviceStateBloc bloc = sl<TrainerDeviceStateBloc>();
              bloc.init();
              return bloc;
            }
          ),
          BlocProvider<HeartRateDeviceStateBloc>(
            create: (BuildContext context) {
              HeartRateDeviceStateBloc bloc = sl<HeartRateDeviceStateBloc>();
              bloc.init();
              return bloc;
            }
          )
        ],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DeviceStatus<TrainerDeviceStateBloc>(icon: Icons.directions_bike),
            DeviceStatus<HeartRateDeviceStateBloc>(icon: FontAwesomeIcons.heartbeat),
          ],
        ),
      ),
    );

  }

}

class DeviceStatus<B extends DeviceStateBloc> extends StatelessWidget {

  final IconData icon;

  const DeviceStatus({@required this.icon});

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


class DashboardButtonTitle extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text('Bluetooth Devices', style: TextStyle(color: Colors.white, fontSize: 20),),
    );
  }

}

class DashboardButtonSeparator extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      color: Colors.cyan,    
    );
  }

}

class DashboardButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(

      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -60,
              top: -20,
              child: Icon(Icons.bluetooth, size: 150, color: Colors.white.withOpacity(0.2),),
            ),
            Column(
              children: <Widget>[
                DashboardButtonTitle(),
                DashboardButtonSeparator(),
                DevicesStatus()
              ],
            ),
          ],
        ),
      ),

      width: double.infinity,
      //height: 100,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(4, 6), blurRadius: 10)
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: <Color>[
            Colors.lightBlue,
            Colors.blue,
          ]
        )
      ),

    );
  }
}