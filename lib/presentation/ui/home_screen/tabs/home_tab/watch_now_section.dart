import 'package:flutter/material.dart';

class WatchNowSection extends StatefulWidget {
  final List<String> images;
   const WatchNowSection({super.key,required this.images});

  @override
  State<WatchNowSection> createState() => _WatchNowSectionState();
}

class _WatchNowSectionState extends State<WatchNowSection> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics:PageScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(widget.images[index]),
              fit: BoxFit.fill,
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
      const SizedBox(width: 20),
      itemCount: widget.images.length,
    );
  }
}
