import 'package:flutter/material.dart';

class GuestCounter extends StatelessWidget {
  final String title, subtitle;
  final int value;
  final VoidCallback onMinus, onPlus;

  const GuestCounter(
      {super.key, required this.title, required this.subtitle, required this.value, required this.onMinus, required this.onPlus});

  @override Widget build(BuildContext c) =>
      Container(height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFF151E30),
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: const Color(0xFF25334A))),
          child: Row(children: [
            Expanded(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(
                      color: Color(0xFF9AA8BF), fontSize: 12))
                ])),
            _Button(icon: Icons.remove, onTap: onMinus),
            SizedBox(width: 32,
                child: Center(child: Text('$value', style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w800)))),
            _Button(icon: Icons.add, onTap: onPlus)
          ]));
}

class _Button extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _Button({required this.icon, required this.onTap});

  @override Widget build(BuildContext c) =>
      Material(color: const Color(0xFF243149),
          borderRadius: BorderRadius.circular(11),
          child: InkWell(onTap: onTap,
              borderRadius: BorderRadius.circular(11),
              child: SizedBox(
                  width: 34, height: 34, child: Icon(icon, size: 19))));
}
