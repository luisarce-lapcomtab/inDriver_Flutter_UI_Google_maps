part of 'widgets.dart';

class InputFare extends StatefulWidget {
  const InputFare({super.key});

  @override
  State<InputFare> createState() => _InputFareState();
}

class _InputFareState extends State<InputFare> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 3.5,
                    width: 35,
                  ),
                  TextField(
                    onSubmitted: onSubmitted,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    cursorColor: Colors.black,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                        helperText: 'Specify a reasonable fare',
                        helperStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                        prefixText: 'USD',
                        prefixStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 17),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: MaterialButton(
                        child: const Text('Cash'), onPressed: () {}),
                  ),
                ],
              ),
            ),
            Container(
                height: 50,
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: MaterialButton(
                  child: const Text(
                    'Close',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ))
          ],
        ),
      ),
    );
  }

  void onSubmitted(String query) {
    if (query.isNotEmpty) {
      Navigator.of(context).pop();
    }
  }
}
