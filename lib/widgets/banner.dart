part of 'widgets.dart';

class BannerMsj extends StatelessWidget {
  const BannerMsj({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding: const EdgeInsets.only(top: 8),
          alignment: Alignment.topCenter,
          height: 320,
          color: const Color.fromARGB(255, 119, 202, 63),
          child: const Text(
            'Gana un extra como repartidor',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}
