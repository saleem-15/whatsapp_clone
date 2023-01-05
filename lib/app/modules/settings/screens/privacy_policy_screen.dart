// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone/config/theme/my_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  final text = ''' Odio eu feugiat pretium nibh ipsum consequat nisl,
Tempus quam pellentesque nec nam aliquam sem et
tortor consequat. Elit eget gravida cum sociis natoque
penatibus. Sed elementum tempus egestas sed sed risus.
ld interdum velit laoreet id donec ultrices. Fermentum
leo vel orci porta non pulvinar neque laoreet. In mollis
nunc sed id semper risus in hendrerit gravida. Venenatis
lectus magna fringilla uma porttitor rhoncus dolor
purus. Erat nam at lectus urna duis convallis convallis.
Interdum velit laoreet id donec ultrices tincidunt arcu.
Sit amet venenatis urna cursus eget nunc scelerisque
viverra. Purus in massa tempor nec feugiat. Hendrerit
gravida rutrum quisque non tellus orci ac auctor augue.
Aenean vel elit scelerisque mauris pellentesque.
Odio eu feugiat pretium nibh ipsum consequat nisl.
Tempus quam pellentesque nec nam aliquam sem et
tortor consequat. Elit eget gravida cum sociis natoque
penatibus. Sed elementum tempus egestas sed sed risus.
ld interdum velit laoreet id donec ultrices. Fermentum
leo vel orci porta non pulvinar neque laoreet. In mollis
nunc sed id semper risus in hendrerit gravida. Venenatis
lectus magna fringilla urna porttitor rhoncus dolor
purus. Erat nam at lectus urna duis convallis convallis.
Interdum velit laoreet id donec ultrices tincidunt arcu.
Lorem ipsum dolor sit amet, consectetur adipiscing elit,
sed do eiusmod tempor incididunt ut labore et dolore
magna aliqua, Uma id volutpat lacus laoreet non
curabitur gravida arcu. Amet nisl purus in mollis nunc
sed id. Elementum curabitur vitae nunc sed. A
pellentesque sit amet porttitor eget. Ac turpis egestas''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privay Policy'),
      ),
      body: ListView(
        padding: MyStyles.getHorizintalScreenPadding().copyWith(
          bottom: 10.sp,
        ),
        children: [
          const Divider(
            height: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                // color: Theme.of(context).disabledColor,
                ),
          ),
        ],
      ),
    );
  }
}
