import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:school_app/modules/home/provider/home_provider.dart';

class WrapperProvider {
  WrapperProvider._();
  static List<SingleChildWidget> wrapperList = [
    ChangeNotifierProvider(create: (_) => HomeProvider()),
  ];
}
