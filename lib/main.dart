import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String DSN_URL = (await rootBundle.loadString('lib/sentry/sentry_dsn.txt'));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.ios);
  await SentryFlutter.init(
      (options) {
        options.dsn = DSN_URL;
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },

      appRunner: () => runApp(const App()),

  );
}

