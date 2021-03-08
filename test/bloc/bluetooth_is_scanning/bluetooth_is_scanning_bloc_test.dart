

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:trainerapp/api/use_cases/bluetooth_use_cases.dart';
import 'package:trainerapp/bloc/bluetooth_is_scanning/bluetooth_is_scanning_bloc.dart';

class MockBluetoothUseCases extends Mock 
    implements BluetoothUseCases {}

Stream<bool> _getTrue() async* {yield true;}
Stream<bool> _getFalse() async* {yield false;}
Stream<bool> _getTrueFalse() async* {
  for(int i = 0; i < 2; i++) {
    if (i == 0) 
      yield true;
    else 
      yield false;
  }
}

void main() {

  group('BluetoothIsScanningBloc', () {

    BluetoothIsScanningBloc bloc;
    MockBluetoothUseCases useCases;

    setUp(() {
      useCases = MockBluetoothUseCases();
    });

    test('Initial state is false', () {
      when(useCases.isScanning())
          .thenAnswer(
              (_) => Right(_getFalse())
      );
      bloc = BluetoothIsScanningBloc(useCases: useCases);
      expect(bloc.initialState, false);
    });

    blocTest(
      'BluetoothIsScanningBloc emits [] when <stoped> is added', 
      build: () async {
        when(useCases.isScanning())
            .thenAnswer(
                (_) => Right(_getFalse())
        );
        bloc = BluetoothIsScanningBloc(useCases: useCases);
        return bloc;
      },
      act: (bloc) => bloc.add(BluetoothIsScanningEvent.stoped),
      expect: [], 
    );

    blocTest(
      'BluetoothIsScanningBloc emits [true] when <started> is added', 
      build: () async {
        when(useCases.isScanning())
            .thenAnswer(
                (_) => Right(_getTrue())
        );
        bloc = BluetoothIsScanningBloc(useCases: useCases);
        return bloc;
      },
      expect: [true], 
    );

  });

}

