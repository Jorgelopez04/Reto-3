import 'package:books/main.dart';
import 'package:books/services/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> openApp(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    // rootBundle guarda en cache el Future del JSON; un Future creado en
    // otro test nunca completa en el test actual.
    rootBundle.evict(BookService.localPath);
  });

  testWidgets('La lista muestra el encabezado y los libros locales', (
    tester,
  ) async {
    await openApp(tester);

    expect(find.text('Mis libros'), findsOneWidget);
    expect(find.text('Tu próxima lectura'), findsOneWidget);
    expect(find.text('9 libros para explorar'), findsOneWidget);
    expect(find.text('El Principito'), findsOneWidget);
  });

  testWidgets('La estrella marca y desmarca el favorito', (tester) async {
    await openApp(tester);

    await tester.tap(find.byTooltip('Marcar como favorito').first);
    await tester.pump();
    expect(find.byTooltip('Quitar favorito'), findsOneWidget);

    await tester.tap(find.byTooltip('Quitar favorito'));
    await tester.pump();
    expect(find.byTooltip('Quitar favorito'), findsNothing);
  });

  testWidgets('Tocar una tarjeta abre el detalle del libro', (tester) async {
    await openApp(tester);

    await tester.tap(find.text('El Principito'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle del libro'), findsOneWidget);
    expect(find.text('Antoine de Saint-Exupéry'), findsOneWidget);
    expect(find.text('Sinopsis'), findsOneWidget);
    expect(find.byType(Chip), findsNWidgets(2));
  });
}
