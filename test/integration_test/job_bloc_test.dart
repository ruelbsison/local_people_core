import 'package:bloc_test/bloc_test.dart';
import 'package:local_people_core/jobs.dart';
import 'package:mockito/mockito.dart';
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJobBloc extends MockBloc<JobEvent> implements JobBloc {}

//class MockJobRepository extends Mock implements JobRepository {}

void main() {
  //MockJobRepository mockJobRepository;

  // setUp(() {
  //   mockJobRepository = MockJobRepository();
  // });

  // blocTest(
  //   'emits [WeatherLoading, WeatherError] when unsuccessful',
  //   build: () {
  //     when(mockWeatherRepository.fetchWeather(any)).thenThrow(NetworkError());
  //     return JobBloc(
  //       jobRepository: jobRepository,
  //       appType: appType,
  //       authLocalDataSource: authLocalDataSource,
  //     );
  //   },
  //   act: (bloc) => bloc.add(GetWeather('London')),
  //   expect: [
  //     WeatherInitial(),
  //     WeatherLoading(),
  //     WeatherError("Couldn't fetch weather. Is the device online?"),
  //   ],
  // );
  //
  // group('JobBloc', () {
  //   blocTest(
  //     'emits [] when nothing is added',
  //     build: () => JobBloc(),
  //     expect: () => [],
  //   );
  //
  //   blocTest(
  //     'emits [1] when CounterEvent.increment is added',
  //     build: () => CounterBloc(),
  //     act: (bloc) => bloc.add(CounterEvent.increment),
  //     expect: () => [1],
  //   );
  // });
  //
  // blocTest(
  //   'emits [WeatherLoading, WeatherError] when unsuccessful',
  //   build: () {
  //     when(mockWeatherRepository.fetchWeather(any)).thenThrow(NetworkError());
  //     return WeatherBloc(mockWeatherRepository);
  //   },
  //   act: (bloc) => bloc.add(GetWeather('London')),
  //   expect: [
  //     WeatherInitial(),
  //     WeatherLoading(),
  //     WeatherError("Couldn't fetch weather. Is the device online?"),
  //   ],
  // );
}
//
// // Mock Cubit
// class MockCounterCubit extends MockCubit<int> implements CounterCubit {}
//
// // Mock Bloc
// class MockCounterBloc extends MockBloc<CounterEvent, int>
//     implements CounterBloc {}
//
// void main() {
//   setUpAll(() {
//     registerFallbackValue<CounterEvent>(CounterEvent.increment);
//   });
//
//   mainCubit();
//   mainBloc();
// }

// void mainCubit() {
//   group('whenListen', () {
//     test("Let's mock the CounterCubit's stream!", () {
//       // Create Mock CounterCubit Instance
//       final cubit = MockCounterCubit();
//
//       // Stub the listen with a fake Stream
//       whenListen(cubit, Stream.fromIterable([0, 1, 2, 3]));
//
//       // Expect that the CounterCubit instance emitted the stubbed Stream of
//       // states
//       expectLater(cubit.stream, emitsInOrder(<int>[0, 1, 2, 3]));
//     });
//   });
//
//   group('CounterCubit', () {
//     blocTest<CounterCubit, int>(
//       'emits [] when nothing is called',
//       build: () => CounterCubit(),
//       expect: () => const <int>[],
//     );
//
//     blocTest<CounterCubit, int>(
//       'emits [1] when increment is called',
//       build: () => CounterCubit(),
//       act: (cubit) => cubit.increment(),
//       expect: () => const <int>[1],
//     );
//   });
// }
//
// void mainBloc() {
//   group('whenListen', () {
//     test("Let's mock the CounterBloc's stream!", () {
//       // Create Mock CounterBloc Instance
//       final bloc = MockCounterBloc();
//
//       // Stub the listen with a fake Stream
//       whenListen(bloc, Stream.fromIterable([0, 1, 2, 3]));
//
//       // Expect that the CounterBloc instance emitted the stubbed Stream of
//       // states
//       expectLater(bloc.stream, emitsInOrder(<int>[0, 1, 2, 3]));
//     });
//   });
//
//   group('CounterBloc', () {
//     blocTest<CounterBloc, int>(
//       'emits [] when nothing is added',
//       build: () => CounterBloc(),
//       expect: () => const <int>[],
//     );
//
//     blocTest<CounterBloc, int>(
//       'emits [1] when CounterEvent.increment is added',
//       build: () => CounterBloc(),
//       act: (bloc) => bloc.add(CounterEvent.increment),
//       expect: () => const <int>[1],
//     );
//   });
// }
//
// class CounterCubit extends Cubit<int> {
//   CounterCubit() : super(0);
//
//   void increment() => emit(state + 1);
// }
//
// enum CounterEvent { increment }
//
// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0);
//
//   @override
//   Stream<int> mapEventToState(CounterEvent event) async* {
//     switch (event) {
//       case CounterEvent.increment:
//         yield state + 1;
//         break;
//     }
//   }
// }