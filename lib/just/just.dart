import 'package:just_notes/just/brand/brand.dart';
import 'package:just_notes/just/components/buttons.dart';
import 'package:just_notes/just/components/icons.dart';
import 'package:just_notes/just/components/text.dart';
import 'package:just_notes/just/components/widgets.dart';
import 'package:just_notes/just/dialogs/auth.dart';
import 'package:just_notes/just/dialogs/dialogs.dart';
import 'package:just_notes/just/theme/animations.dart';
import 'package:just_notes/just/theme/colors.dart';
import 'package:just_notes/just/theme/sizes.dart';
import 'package:url_launcher/url_launcher.dart';


typedef JustBrand = JBrand;

typedef JustButtons = JButtons;

typedef JustIcons = JIcons;
typedef JustText = JText;
typedef JustWidgets = JWidgets;

typedef JustAuth = Auth;
typedef JustDialogs = JDialogs;

typedef JustAnimations = JAnimations;
typedef JustColors = JColors;
typedef JustSizes = JSizes;


Future<bool> justLaunchUrl(String path) => launchUrl(
  Uri.parse(path),
  mode: LaunchMode.externalApplication,
);