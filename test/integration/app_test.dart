import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_idez/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('integration flow: add toggle delete', (tester) async {
    SharedPreferences.setMockInitialValues({});
    app.main();
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Integra');
    await tester.tap(find.text('Criar'));
    await tester.pumpAndSettle();

    expect(find.text('Integra'), findsOneWidget);

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pumpAndSettle();

    await tester.drag(find.text('Integra'), Offset(-500, 0));
    await tester.pumpAndSettle();

    expect(find.text('Integra'), findsNothing);
  });
}
