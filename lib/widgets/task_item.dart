import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Импортируем пакет для форматирования даты

class TaskItem extends StatefulWidget {
  final String title;
  final String description;
  final DateTime deadline; // Изменяем тип deadline на DateTime
  final TaskPriority priority; // Добавляем enum для приоритета
  final Function(String) onDelete; // Функция для удаления задачи
  final Function(String) onEdit; // Функция для редактирования задачи

  const TaskItem({
    Key? key,
    required this.title,
    required this.description,
    required this.deadline,
    required this.priority,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late TaskPriority _currentPriority; // Сохраняем текущий приоритет

  @override
  void initState() {
    super.initState();
    _currentPriority = widget.priority; // Инициализируем текущий приоритет
  }

  @override
  Widget build(BuildContext context) {
    return Container( // Добавляем Container для градиента
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: getGradientForPriority(_currentPriority), // Получаем градиент
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded( // Занимаем всю доступную ширину для текста
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, //  текст для контраста
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 14, color: Colors.black), // текст для контраста
                ),
                const SizedBox(height: 8),
                Text(
                  'Дедлайн: ${DateFormat('dd.MM.yy HH:mm').format(widget.deadline)}', // Форматируем дату
                  style: const TextStyle(fontSize: 14, color: Colors.black), //  текст для контраста
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // Отступ между текстом и кнопкой
          Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentPriority = getNextPriority(_currentPriority);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: getPriorityColor(_currentPriority),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  minimumSize: const Size(48, 48), // Размер кнопки
                ),
                child: Text(getPriorityText(_currentPriority)),
              ),
              const SizedBox(height: 8), // Отступ между кнопками
              IconButton(
                onPressed: () {
                  widget.onEdit(widget.title); // Вызываем функцию редактирования
                },
                icon: const Icon(Icons.edit),
              ),
              const SizedBox(height: 8), // Отступ между кнопками
              IconButton(
                onPressed: () {
                  widget.onDelete(widget.title); // Вызываем функцию удаления
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Функция для получения градиента в зависимости от приоритета
  LinearGradient getGradientForPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return const LinearGradient(
          colors: [Colors.red, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        );
      case TaskPriority.medium:
        return const LinearGradient(
          colors: [Colors.yellow, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        );
      case TaskPriority.low:
        return const LinearGradient(
          colors: [Colors.green, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        );
    }
  }

  // Функция для получения следующего приоритета
  TaskPriority getNextPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return TaskPriority.medium;
      case TaskPriority.medium:
        return TaskPriority.high;
      case TaskPriority.high:
        return TaskPriority.low;
    }
  }

  // Функция для получения цвета приоритета
  Color getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.yellow;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  // Функция для получения текста приоритета
  String getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return '!!!';
      case TaskPriority.medium:
        return '!!';
      case TaskPriority.low:
        return '!';
    }
  }
}

// Enum для приоритета задачи
enum TaskPriority { high, medium, low }
