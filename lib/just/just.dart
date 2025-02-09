import 'package:just_notes/just/brand/brand.dart';
import 'package:just_notes/just/components/buttons.dart';
import 'package:just_notes/just/components/icons.dart';
import 'package:just_notes/just/components/text.dart';
import 'package:just_notes/just/components/widgets.dart';
import 'package:just_notes/just/os/auth.dart';
import 'package:just_notes/just/theme/animations.dart';
import 'package:just_notes/just/theme/colors.dart';
import 'package:just_notes/just/theme/sizes.dart';
import 'package:url_launcher/url_launcher.dart';


enum JustButtonAction {
  delete,
  external,
  next,
}


typedef JustBrand = JBrand;
typedef JustButtons = JButtons;
typedef JustIcons = JIcons;
typedef JustText = JText;
typedef JustWidgets = JWidgets;
typedef JustAuth = Auth;
typedef JustColors = JColors;
typedef JustAnimations = Animations;
typedef JustSizes = JSizes;


Future<bool> justLaunchUrl(String path) => launchUrl(
  Uri.parse(path),
  mode: LaunchMode.externalApplication,
);