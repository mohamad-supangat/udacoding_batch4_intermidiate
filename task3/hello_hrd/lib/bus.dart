import 'package:flutter/material.dart';
import 'package:event_bus/event_bus.dart';

// eventbuss
EventBus eventBus = EventBus();

class RefreshListEmployeesBus {}

// navigtor utama
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
