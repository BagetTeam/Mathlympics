import 'package:flutter/material.dart';

class PlayScreen extends StatelessWidget {
  const PlayScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/play/normal');
                },
                child: Text("Normal")),
            FilledButton(onPressed: () {}, child: Text("Ranked")),
          ],
        ),
      ),
    );
  }
}

class PlayNormal extends StatelessWidget {
  const PlayNormal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Play'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/play/normal/cal20');
                },
                child: Text("Calculation x20")),
            FilledButton(onPressed: () {}, child: Text("Integrals")),
          ],
        ),
      ),
    );
  }
}

class PlayRanked extends StatelessWidget {
  const PlayRanked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
