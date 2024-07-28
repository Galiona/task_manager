import 'package:flutter/material.dart';
import '../widgets/task_item.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  // Список задач (замените на данные из Firebase)
  List<String> tasks = [
    'Купить продукты',
    'Записаться на прием к врачу',
    'Сделать уборку',
    'Позвонить другу',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          title: tasks[index],
          description: 'Описание задачи',
          deadline: DateTime.now(),
          priority: TaskPriority.low,
          onEdit: (String title) {
            // Логика редактирования задачи
            print('Редактируется задача: $title');
          },
          onDelete: (String title) {
            setState(() {
              tasks.remove(title); // Удаляем задачу из списка
            });
          },
        );
      },
    );
  }
}
