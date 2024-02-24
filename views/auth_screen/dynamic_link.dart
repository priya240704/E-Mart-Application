import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share_plus/share_plus.dart';

class DynamicLinkProider{
  Future<String> createlink(String refcode) async {
    final String url = "https://com.example.shopping_app?ref=$refcode";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      androidParameters: AndroidParameters(packageName: "com.example.shopping_app",minimumVersion: 0),
        iosParameters: IOSParameters(bundleId: "com.example.shopping_app",minimumVersion: "0"),
        link: Uri.parse(url),
        uriPrefix: "https://allproduct.page.link");

    final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
    final refLink = await link.buildShortLink(parameters);
    return refLink.shortUrl.toString();
  }

  void initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if(instanceLink != null){
      final Uri refLink = instanceLink.link;
      Share.share("this is the link ${refLink.data}");
    }

  }

}