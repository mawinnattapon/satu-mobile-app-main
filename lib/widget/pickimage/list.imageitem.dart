import 'dart:io';

import 'package:flutter/material.dart';

class ListImageItem extends StatelessWidget {
  const ListImageItem({
    Key? key,
    required this.file,
    required this.onDelete,
    required this.isMouse,
  }) : super(key: key);

  final String file;
  final bool isMouse;
  final Function(String path) onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: file.contains('http')
                ? Image.network(
                    file,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(file),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const Positioned.fill(child: AbsorbPointer()),
        Positioned(
          right: 0,
          top: 0,
          child: InkWell(
            onTap: isMouse
                ? null
                : () {
                    onDelete(file);
                  },
            onTapDown: isMouse
                ? (d) {
                    onDelete(file);
                  }
                : null,
            child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.black,
                )),
          ),
        ),
      ],
    );
  }
}
