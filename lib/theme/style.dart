import 'package:flutter/material.dart';
import 'package:srr_management/theme/colors.dart';

TextStyle kHeaderStyle() => const TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
TextStyle kWhiteHeaderStyle() => const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
TextStyle kBoldStyle() => const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
TextStyle k14BoldStyle() => const TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
TextStyle k14Text() => const TextStyle(fontSize: 14);
TextStyle k12Text() => const TextStyle(fontSize: 12);
TextStyle k10Text() => const TextStyle(fontSize: 10);
TextStyle k16Style() => const TextStyle(fontSize: 16);
TextStyle k20BStyle() => const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
TextStyle kLargeStyle() => const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
TextStyle kVLargeStyle() => const TextStyle(fontSize: 24, fontWeight: FontWeight.w600,);
TextStyle kWhiteTextStyle() => TextStyle(color: kWhiteColor);
TextStyle tagTextStyle() => TextStyle(fontSize: 12, color: kWhiteColor);

TextStyle linkTextStyle(context) => TextStyle(
    color: Theme.of(context).textTheme.bodyMedium?.color,
    fontWeight: FontWeight.bold, fontSize: 14);

double kIconSize() => 18.0;
SizedBox kSpace({height}) => SizedBox(height: height??15.0);
Widget kDivider() => const Padding(
  padding: EdgeInsets.symmetric(vertical: 10),
  child: Divider(thickness: 1),
);
SizedBox kBottomSpace() => const SizedBox(height: 80.0);

RoundedRectangleBorder materialButtonDesign() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0));
}

RoundedRectangleBorder bottomSheetRoundedDesign() {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.0),
      )
  );
}

BoxDecoration containerDesign(context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor != Colors.black ? Colors.white : kDarkColor,
  );
}

BoxDecoration roundedContainerDesign(context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor != Colors.black ? Colors.white : kDarkColor,
    borderRadius: BorderRadius.circular(10.0),
  );
}

BoxDecoration roundedShadedDesign(context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor != Colors.black ? Colors.white : kDarkColor,
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: boxShadowDesign(),
  );
}

BoxDecoration blurCurveDecor(BuildContext context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor != Colors.black ?
    Colors.white.withOpacity(0.6) : kDarkColor.withOpacity(0.7),
    borderRadius: BorderRadius.circular(10.0),
  );
}

List<BoxShadow> boxShadowDesign() {
  return [
    BoxShadow(
      color: kMainColor.withOpacity(0.3),
      spreadRadius: 2.0,
      blurRadius: 5.0,
      offset: const Offset(1,2),
    ),
  ];
}

LinearGradient kBottomShadedShadow() {
  return LinearGradient(
    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: const [0.0, 1.0],
    tileMode: TileMode.clamp,
  );
}

BoxDecoration dropTextFieldDesign(context) {
  return BoxDecoration(
    color: Theme.of(context).scaffoldBackgroundColor,
    borderRadius: BorderRadius.circular(15.0),
    border: Border.all(width: 0.5, color: Colors.grey.shade400),
  );
}

// Widget kWhiteRowText(String title, String detail) {
//   return Column(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title, style: kWhiteTextStyle()),
//           Spacer(),
//           Text(detail, style: kWhiteTextStyle()),
//         ],
//       ),
//       Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5.0),
//         child: Divider(
//           thickness: 1,
//           color: kWhiteColor,
//         ),
//       ),
//     ],
//   );
// }

// Column kColumnText(context, String title, String desc) {
//   return Column(
//     children: [
//       Text(title, style: kBoldStyle()),
//       Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           color: Colors.grey.withOpacity(0.4),
//         ),
//         child: Text(desc),
//       ),
//     ],
//   );
// }

Row kRowText(String title, String desc){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: kBoldStyle()),
      Expanded(child: Text(desc)),
    ],
  );
}

Row kRowSpaceText(String title, String desc){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: kBoldStyle()),
      const SizedBox(width: 10.0),
      Expanded(child: Text(desc, textAlign: TextAlign.end)),
    ],
  );
}

LinearGradient shadedTopGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: FractionalOffset.bottomCenter,
    stops: const [0.0, 1.0],
    colors: [const Color(0xffA66DD4).withOpacity(0.5), Colors.transparent],
  );
}

BoxDecoration kBackgroundDesign(BuildContext context) {
  return BoxDecoration(
    image: DecorationImage(
      image: const AssetImage('images/01.jpg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Theme.of(context).scaffoldBackgroundColor != Colors.black ?
        Colors.transparent : Colors.black.withOpacity(0.3),
        BlendMode.srcATop,
      ),
    ),
  );
}
