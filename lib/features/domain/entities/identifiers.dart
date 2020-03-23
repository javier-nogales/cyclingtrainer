
import 'package:collection/collection.dart';

class DeviceID {
  final String _id;
  const DeviceID(this._id);
  @override
  String toString() => _id;
  @override
  int get hashCode => _id.hashCode;
  @override
  bool operator ==(other) =>
      other is DeviceID && compareAsciiLowerCase(other._id, _id) == 0;
}