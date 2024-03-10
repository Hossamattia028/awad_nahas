import 'package:awad_nahas/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_event.dart';
import 'package:awad_nahas/features/cart/presentation/bloc/cart_state.dart';
import 'package:awad_nahas/features/cart/presentation/widgets/coupon_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class TestMockCartBloc extends MockBloc<CartEvent, CartState>
    implements CartBloc {}

void main() async {
  // late MockCartBloc mockCartBloc;

  // setUp(() {
  //   mockCartBloc = MockCartBloc();
  // });

  testWidgets('Test', (WidgetTester tester) async {
    final mockCartBloc = TestMockCartBloc();
    when(mockCartBloc.initialState)
        .thenReturn(const CartInitialState()); // stub state rather than initialState
    whenListen(
      mockCartBloc,
      Stream<CartInitialState>.fromIterable([
        const CartInitialState(),
      ]),
    );

    await tester.pumpWidget(
      BlocProvider<CartBloc>(
        create: (context) => mockCartBloc,
        child: const CouponTest(),
      ),
    );

    await tester.pump(Duration.zero);
    expect(find.text('go'), findsOneWidget);
  });
}
