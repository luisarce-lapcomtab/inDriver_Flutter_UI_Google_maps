part of 'widgets.dart';

class BtnMenu extends StatelessWidget {
  const BtnMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      left: 10,
      child: FloatingActionButton(
        mini: true,
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.menu,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}

class BtnShare extends StatelessWidget {
  const BtnShare({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: 10,
      child: FloatingActionButton(
        mini: true,
        onPressed: () {},
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.share,
          color: Colors.black,
          size: 25,
        ),
      ),
    );
  }
}

class BtnRequest extends StatelessWidget {
  const BtnRequest({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 89, 185, 25),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        height: 52,
        child: const Text(
          "Request a vehicle",
          style: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
