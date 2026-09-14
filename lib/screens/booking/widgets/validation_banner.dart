import 'package:flutter/material.dart';

class ValidationBanner extends StatelessWidget {
  final String message;
  final bool isError;

  const ValidationBanner({
    super.key,
    required this.message,
    required this.isError,
  });

  @override
  Widget build(BuildContext c) {
    final fg = isError ? const Color(0xFFFF8F9C) : const Color(0xFF49E5BD);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isError ? const Color(0xFF2B171B) : const Color(0xFF092923),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isError ? const Color(0xFFB84755) : const Color(0xFF008F73),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isError ? Icons.error_outline_rounded : Icons.check_circle_outline,
            color: fg,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: fg,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
