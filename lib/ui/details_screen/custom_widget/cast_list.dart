import 'package:flutter/material.dart';

import 'cast_member_item.dart';

class CastList extends StatelessWidget {
  final List<dynamic> cast;
  final double width;
  final double height;

  const CastList({
    super.key,
    required this.cast,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cast.length,
      itemBuilder: (context, index) {
        final castMember = cast[index];
        return CastMemberItem(
          castMember: castMember,
          width: width,
          height: height,
        );
      },
    );
  }
}
