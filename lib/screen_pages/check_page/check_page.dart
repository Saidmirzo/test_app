import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/domain/models/todos_model.dart';
import 'package:news/utils/const.dart';

import '../../bloc/check/check_bloc.dart';
import '../../domain/Widgets/widgets.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> animG;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animG = Tween<Alignment>(begin: Alignment.topLeft, end: Alignment.bottomRight).animate(_controller);
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckBloc, CheckState>(
      builder: (context, state) {
        if (state is CheckStateComlated) {
          List<TodosModel> listTodos = state.listTodos;
          return Container(
            color: const Color(0xff0F0C21),
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<CheckBloc>().add(const CheckEventLoadTodos());
              },
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: List.generate(listTodos.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Checkbox(value: listTodos[index].completed ?? false, onChanged: (context) {}),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            listTodos[index].title!,
                            style: sTextStyle(
                              color: Colors.white,
                              size: 18,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          );
        } else {
          return AnimLoad(
            animContainer(),
            animG: animG,
          );
        }
      },
    );
  }

  ListView animContainer() {
    return ListView(
      children: List.generate(11, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          color: const Color(0xff0F0C21),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(border: Border.all(color: Colors.white, style: BorderStyle.solid)),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 15,
                width: 200,
                color: Colors.white,
              )
            ],
          ),
        );
      }),
    );
  }
}
