import 'package:flutter/material.dart';
import 'package:nekolib.ui/ui.dart';
import 'widgets/codeblock/code_block.dart';

class CodeBook extends StatefulWidget {
  const CodeBook({Key? key}) : super(key: key);

  @override
  _CodeBookState createState() => _CodeBookState();
}

class _CodeBookState extends State<CodeBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(NcSpacing.largeSpacing),
      child: ListView(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          CodeBlock(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In pellentesque massa placerat duis ultricies. Augue eget arcu dictum varius duis at consectetur lorem donec. Augue neque gravida in fermentum et sollicitudin ac orci. Adipiscing diam donec adipiscing tristique risus nec feugiat. Euismod lacinia at quis risus sed. Leo integer malesuada nunc vel risus commodo viverra maecenas accumsan. Senectus et netus et malesuada fames ac turpis. Pulvinar etiam non quam lacus suspendisse. Nisl purus in mollis nunc sed id semper risus in. Neque ornare aenean euismod elementum nisi quis eleifend quam. Lectus quam id leo in vitae. Etiam tempor orci eu lobortis elementum nibh tellus molestie. Duis at tellus at urna condimentum",
              language: "catgirl",
              tags: ["dasdasd", "dasdad"],
              code: "deine mom"),
          NcSpacing.xl(),
          CodeBlock(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In pellentesque massa placerat duis ultricies. Augue eget arcu dictum varius duis at consectetur lorem donec. Augue neque gravida in fermentum et sollicitudin ac orci. Adipiscing diam donec adipiscing tristique risus nec feugiat. Euismod lacinia at quis risus sed. Leo integer malesuada nunc vel risus commodo viverra maecenas accumsan. Senectus et netus et malesuada fames ac turpis. Pulvinar etiam non quam lacus suspendisse. Nisl purus in mollis nunc sed id semper risus in. Neque ornare aenean euismod elementum nisi quis eleifend quam. Lectus quam id leo in vitae. Etiam tempor orci eu lobortis elementum nibh tellus molestie. Duis at tellus at urna condimentum",
              language: "catgirl",
              tags: ["dasdasd", "dasdad"],
              code: "deine mom"),
          NcSpacing.xl(),
          CodeBlock(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In pellentesque massa placerat duis ultricies. Augue eget arcu dictum varius duis at consectetur lorem donec. Augue neque gravida in fermentum et sollicitudin ac orci. Adipiscing diam donec adipiscing tristique risus nec feugiat. Euismod lacinia at quis risus sed. Leo integer malesuada nunc vel risus commodo viverra maecenas accumsan. Senectus et netus et malesuada fames ac turpis. Pulvinar etiam non quam lacus suspendisse. Nisl purus in mollis nunc sed id semper risus in. Neque ornare aenean euismod elementum nisi quis eleifend quam. Lectus quam id leo in vitae. Etiam tempor orci eu lobortis elementum nibh tellus molestie. Duis at tellus at urna condimentum",
              language: "catgirl",
              tags: ["dasdasd", "dasdad"],
              code: "deine mom"),
          NcSpacing.xl(),
          CodeBlock(
              description:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. In pellentesque massa placerat duis ultricies. Augue eget arcu dictum varius duis at consectetur lorem donec. Augue neque gravida in fermentum et sollicitudin ac orci. Adipiscing diam donec adipiscing tristique risus nec feugiat. Euismod lacinia at quis risus sed. Leo integer malesuada nunc vel risus commodo viverra maecenas accumsan. Senectus et netus et malesuada fames ac turpis. Pulvinar etiam non quam lacus suspendisse. Nisl purus in mollis nunc sed id semper risus in. Neque ornare aenean euismod elementum nisi quis eleifend quam. Lectus quam id leo in vitae. Etiam tempor orci eu lobortis elementum nibh tellus molestie. Duis at tellus at urna condimentum",
              language: "catgirl",
              tags: ["dasdasd", "dasdad"],
              code: "deine mom"),
          NcSpacing.xl(),
        ],
      ),
    );
  }
}
