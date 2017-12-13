import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:heroes_companion_data/heroes_companion_data.dart';
import 'package:redux/redux.dart';

import 'package:heroes_companion/redux/reducers/app_state.dart';
import 'package:heroes_companion/redux/middleware/heroes_middleware.dart';
import 'package:heroes_companion/redux/state.dart';
import 'package:heroes_companion/redux/actions/actions.dart';

import 'package:heroes_companion/routes.dart';
import 'package:heroes_companion/view/routes/home_view.dart';
import 'package:heroes_companion/view/common/splash.dart';

final String appName = 'Heroes Companion';
StreamSubscription<AppState> subscription;
App app;

void main() {
  // Listens to onChange events and when the initial load is completed the main app is run
  void listener(AppState state) {
    if (state.isLoading == false && state.heroes != null){
      subscription.cancel();
      runApp(app);
    }
  }

  // Run the splasscreen, create an instance of app, dispatch and event to load the initial data, and setup a listener to check for completion
  runApp(new Splash(appName));
  app = new App();
  // TODO Refactor this
  // Create a dataprovider singleton, start it then when it's ready dispatch an event
  new DataProvider();
  subscription = app.store.onChange.listen(listener);
  DataProvider.start().then((a) {
    app.store.dispatch(new LoadHeroAction());
  });
}

class App extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState.loading(),
    middleware: createHeroMiddleware(),
  ); 

  App();

  @override
  Widget build(BuildContext context) => new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: appName,
        theme: new ThemeData(primaryColor: Colors.deepPurple),
        routes: {
          Routes.home: (context) {
            return new StoreBuilder<AppState>(
              onInit: (store) => store.dispatch(new LoadHeroAction()),
              builder: (context, store) {
                return new HomeScreen();
              },
            );
          }
        }
      ),
    );
}