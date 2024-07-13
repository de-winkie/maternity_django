import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maternity/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  Map<DateTime, List<Event>> events = {};
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    loadPreviousEvents();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

//*GET EVENTS PER DAY
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

//*GET EVENT RANGE
  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final day in days) ..._getEventsForDay(day),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start!;
      _rangeEnd = end; //! exception error (null call a null value)
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // *`start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  void clearController() {
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Text(
                  textAlign: TextAlign.center,
                  DateFormat('MMMM yyyy').format(_selectedDay!),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TableCalendar(
                headerStyle: HeaderStyle(
                    formatButtonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(),
                        color: Theme.of(context).colorScheme.tertiaryContainer),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onInverseSurface)),
                firstDay: DateTime.utc(2000, 12, 31),
                lastDay: DateTime.utc(2030, 01, 01),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  markerDecoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer),
                      color: Theme.of(context).colorScheme.primary),
                  selectedDecoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('images/car.jpeg')),
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                  todayDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                  // Use `CalendarStyle` to customize the UI
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                // Ici, vous pouvez personnaliser l'apparence et le comportement du calendrier selon vos besoins
              ),
              const SizedBox(height: 10.0),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface),
                child: ValueListenableBuilder(
                  builder: (context, value, _) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: value
                          .map((e) => Card(
                              color: Colors.white,
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.check_box,
                                          color: Theme.of(context)
                                              .buttonTheme
                                              .colorScheme!
                                              .secondary,
                                        ),
                                        SizedBox(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  child: Column(children: [
                                                Text(
                                                    maxLines: 1,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16),
                                                    e.title),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text.rich(
                                                      TextSpan(children: [
                                                    TextSpan(
                                                        style: const TextStyle(
                                                            color: Colors.blue),
                                                        text:
                                                            '${_selectedDay!.hour}: ${_selectedDay!.minute}: '),
                                                    TextSpan(
                                                      text: e.description,
                                                    ),
                                                  ])),
                                                )
                                              ])),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.share)
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          textBtn(
                                              context, 'Search ride', () {}),
                                          textBtn(context, 'Cancel Event', () {
                                            setState(() {
                                              _selectedEvents.value.clear();
                                              _getEventsForDay;
                                            });
                                          }),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )))
                          .toList(),
                    );
                    // return ListView.builder(
                    //     primary: true,
                    //     itemCount: value.length,
                    //     shrinkWrap: true,
                    //     itemBuilder: (_, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Card(
                    //             color: Colors.white,
                    //             child: Container(
                    //               margin: const EdgeInsets.symmetric(
                    //                   vertical: 20, horizontal: 14),
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4)),
                    //               child: Column(
                    //                 children: [
                    //                   Row(
                    //                     mainAxisAlignment:
                    //                         MainAxisAlignment.spaceBetween,
                    //                     children: [
                    //                       Icon(
                    //                         Icons.check_box,
                    //                         color: Theme.of(context)
                    //                             .buttonTheme
                    //                             .colorScheme!
                    //                             .secondary,
                    //                       ),
                    //                       SizedBox(
                    //                         child: Column(
                    //                           children: [
                    //                             SizedBox(
                    //                                 child: Column(children: [
                    //                               Row(
                    //                                 children: [
                    //                                   Text(
                    //                                       maxLines: 1,
                    //                                       style:
                    //                                           const TextStyle(
                    //                                               fontWeight:
                    //                                                   FontWeight
                    //                                                       .w500,
                    //                                               fontSize: 16),
                    //                                       value[index].title),
                    //                                   Text(
                    //                                     maxLines: 2,
                    //                                     ' at ${_selectedDay!.hour}: ${_selectedDay!.minute}',
                    //                                     style: const TextStyle(
                    //                                         fontSize: 10),
                    //                                   )
                    //                                 ],
                    //                               ),
                    //                               Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.all(
                    //                                         8.0),
                    //                                 child: Text(
                    //                                   value[index].description,
                    //                                 ),
                    //                               )
                    //                             ])),
                    //                           ],
                    //                         ),
                    //                       ),
                    //                       const Icon(Icons.share)
                    //                     ],
                    //                   ),
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(top: 10),
                    //                     child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.center,
                    //                       children: [
                    //                         textBtn(
                    //                             context, 'Search ride', () {}),
                    //                         textBtn(context, 'Cancel Event',
                    //                             () {
                    //                           setState(() {
                    //                             _selectedEvents.value.clear();
                    //                             _getEventsForDay;
                    //                           });
                    //                         }),
                    //                       ],
                    //                     ),
                    //                   )
                    //                 ],
                    //               ),
                    //             )),
                    //       );
                    //     });
                  
                  },
                  valueListenable: _selectedEvents,
                ),
              )

              //  Vous pouvez également inclure des fonctionnalités telles que la modification ou l'annulation de réservations directement depuis cette liste
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // todo: Show dialog to user to input event
            showDialog(
                context: context, builder: (_) => _dialogWidget(context));
          },
          label: const Text('Add Events'),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget textBtn(BuildContext context, String text, VoidCallback voidCallback) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          voidCallback();
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

// ALERT DIALOG
  AlertDialog _dialogWidget(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: true,
      title: const Text('Event name'),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(helperText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(helperText: 'ride'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              events.addAll({
                _selectedDay!: [
                  ..._selectedEvents.value,
                  Event(
                      title: _titleController.text,
                      description: _descriptionController.text)
                ]
              });
              _selectedEvents.value = _getEventsForDay(_selectedDay!);
              clearController();
              context.pop();
            },
            child: const Text('Submit'))
      ],
    );
  }

  void loadPreviousEvents() {
    events = {
      _selectedDay!: [const Event(title: '', description: '')],
      _selectedDay!: [const Event(title: '', description: '')]
    };
  }

  //   _checkOnboardingCompleted() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // return prefs.getStringList('key');
  //}
}