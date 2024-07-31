import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../screens/profile.dart';
import '../screens/all_tasks.dart'; 

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    TasksPage(),
    Text('Сегодня'),
    Text('Выполнено'),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Состояние для ввода текста новой задачи
  String _newTaskText = '';
  String _newTaskDescription = '';
  DateTime _newTaskDeadline = DateTime.now();

  // Функция для показа диалогового окна
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog( // Используем Dialog вместо AlertDialog
          child: Container( // Добавляем Container для ограничения ширины
            width: 400, // Устанавливаем минимальную ширину
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Сжимаем высоту диалога
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'Введите задачу'),
                  onChanged: (value) {
                    setState(() {
                      _newTaskText = value;
                    });
                  },
                ),
                const SizedBox(height: 16), // Отступ между полями
                TextField(
                  decoration: const InputDecoration(hintText: 'Описание'),
                  onChanged: (value) {
                    setState(() {
                      _newTaskDescription = value;
                    });
                  },
                ),
                const SizedBox(height: 16), // Отступ между полями
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () async {
                          // Вызываем диалог выбора даты и времени
                          DateTime? pickedDateTime = await showDatePicker(
                            context: context,
                            initialDate: _newTaskDeadline,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );

                          if (pickedDateTime != null) {
                            // Вызываем диалог выбора времени
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(_newTaskDeadline),
                            );

                            if (pickedTime != null) {
                              setState(() {
                                _newTaskDeadline = DateTime(
                                  pickedDateTime.year,
                                  pickedDateTime.month,
                                  pickedDateTime.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: Text(
                          'Дедлайн: ${DateFormat('dd.MM.yy HH:mm').format(_newTaskDeadline)}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24), // Отступ между полями и кнопками
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Кнопки справа
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Закрываем диалоговое окно
                      },
                      child: const Text('Отмена'),
                    ),
                    const SizedBox(width: 16), // Отступ между кнопками
                    TextButton(
                      onPressed: () {
                        if (_newTaskText.isNotEmpty) {
                          // Добавляем задачу в список
                          // ... (реализуйте логику добавления задачи)
                          setState(() {
                            // ...
                            _newTaskText = ''; // Очищаем поле ввода
                            _newTaskDescription = ''; // Очищаем поле ввода
                            _newTaskDeadline = DateTime.now(); // Сбрасываем дедлайн
                          });
                        }
                        Navigator.of(context).pop(); // Закрываем диалоговое окно
                      },
                      child: const Text('Добавить'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Прозрачный AppBar
        elevation: 0, // Убираем тень
      ),
      body: Container( // Добавляем Container для градиента
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
            stops: const [0.1, 0.9], // 90% primary, 10% secondary
          ),
        ),
        child: _selectedIndex == 3 // Проверяем, выбран ли "Профиль"
            ? ProfilePage() // Если да, отображаем ProfilePage
            : Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Задачи',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Сегодня',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Выполнено',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex != 3 // Проверяем, не выбран ли "Профиль"
          ? FloatingActionButton(
              onPressed: _showAddTaskDialog,
              child: const Icon(Icons.add),
            )
          : null, // Если "Профиль" выбран, не отображаем кнопку
    );
  }
}
