import 'package:flutter/material.dart';
import 'package:trainerapp/ui/components/kpis/bluetooth_devices_kpi.dart';
import 'package:trainerapp/ui/theme/color_theme.dart';
import 'package:trainerapp/ui/theme/icon_theme.dart';

part 'bluetooth_devices_dashboard.dart';

class _DashboardBase extends StatelessWidget {

  final IconData icon;
  final String title;
  final Widget content;

  final Color iconColor;
  final Function onTap;

  const _DashboardBase({
    @required this.icon,
    @required this.title,
    @required this.content,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Row( 
              children: <Widget>[
                Spacer(flex: 1,),
                Icon(icon, color: iconColor),
                Spacer(flex: 1),
                Text(title, style: Theme.of(context).textTheme.title,),
                Spacer(flex: 10,),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: content
            ),
          ],
        )
      ),
    );
  }
}