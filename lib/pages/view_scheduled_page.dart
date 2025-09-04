import 'package:flutter/material.dart';
import '../widgets/influbee_coin.dart';

class ViewScheduledPage extends StatefulWidget {
  const ViewScheduledPage({super.key});

  @override
  State<ViewScheduledPage> createState() => _ViewScheduledPageState();
}

class _ViewScheduledPageState extends State<ViewScheduledPage> {
  // Mock data for scheduled streams
  final List<ScheduledStream> _scheduledStreams = [
    ScheduledStream(
      id: '1',
      title: 'Q&A Session',
      price: 150,
      scheduledDate: DateTime.now().add(const Duration(days: 2)),
      scheduledTime: const TimeOfDay(hour: 18, minute: 0),
      status: 'Scheduled',
    ),
    ScheduledStream(
      id: '2',
      title: 'Behind the Scenes',
      price: 200,
      scheduledDate: DateTime.now().add(const Duration(days: 5)),
      scheduledTime: const TimeOfDay(hour: 20, minute: 30),
      status: 'Scheduled',
    ),
    ScheduledStream(
      id: '3',
      title: 'Fitness Workout',
      price: 100,
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      scheduledTime: const TimeOfDay(hour: 7, minute: 0),
      status: 'Scheduled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Scheduled Streams',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: _scheduledStreams.isEmpty ? _buildEmptyState() : _buildScheduledList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(60),
            ),
            child: const Icon(
              Icons.schedule,
              color: Color(0xFF10B981),
              size: 60,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'No Scheduled Streams',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'You haven\'t scheduled any live streams yet.\nTap the + button to schedule your first stream!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/schedule_live'),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text(
              'Schedule Stream',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9500),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduledList() {
    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.list_alt,
                  color: Color(0xFF10B981),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_scheduledStreams.length} Scheduled Streams',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Manage your upcoming live streams',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Streams List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: _scheduledStreams.length,
            itemBuilder: (context, index) {
              final stream = _scheduledStreams[index];
              return _buildStreamCard(stream);
            },
          ),
        ),
        
        // Add New Button
        Container(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/schedule_live'),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Schedule New Stream',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9500),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStreamCard(ScheduledStream stream) {
    final isToday = stream.scheduledDate.day == DateTime.now().day &&
                    stream.scheduledDate.month == DateTime.now().month &&
                    stream.scheduledDate.year == DateTime.now().year;
    
    final isTomorrow = stream.scheduledDate.day == DateTime.now().add(const Duration(days: 1)).day &&
                       stream.scheduledDate.month == DateTime.now().add(const Duration(days: 1)).month &&
                       stream.scheduledDate.year == DateTime.now().add(const Duration(days: 1)).year;

    String getDateText() {
      if (isToday) return 'Today';
      if (isTomorrow) return 'Tomorrow';
      return '${stream.scheduledDate.day}/${stream.scheduledDate.month}/${stream.scheduledDate.year}';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Stream Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stream.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  stream.status,
                                  style: const TextStyle(
                                    color: Color(0xFF10B981),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFF9500).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const InflubeeCoin(size: 12),
                                    const SizedBox(width: 4),
                                    Text(
                                      stream.price.toString(),
                                      style: const TextStyle(
                                        color: Color(0xFFFF9500),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.schedule,
                        color: Color(0xFF10B981),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Date and Time
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8B5CF6).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF8B5CF6),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getDateText(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${stream.scheduledTime.hour.toString().padLeft(2, '0')}:${stream.scheduledTime.minute.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Action Buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A).withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _editStream(stream),
                    icon: const Icon(Icons.edit, color: Color(0xFF10B981)),
                    label: const Text(
                      'Edit',
                      style: TextStyle(
                        color: Color(0xFF10B981),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF10B981)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _cancelStream(stream),
                    icon: const Icon(Icons.cancel, color: Color(0xFFEF4444)),
                    label: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFFEF4444),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFEF4444)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _goLiveNow(stream),
                    icon: const Icon(Icons.live_tv, color: Colors.white),
                    label: const Text(
                      'Go Live',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editStream(ScheduledStream stream) {
    // Navigate to schedule live page with pre-filled data
    Navigator.pushNamed(
      context,
      '/schedule_live',
      arguments: {
        'editMode': true,
        'streamId': stream.id,
        'title': stream.title,
        'price': stream.price,
        'scheduledDate': stream.scheduledDate,
        'scheduledTime': stream.scheduledTime,
      },
    );
  }

  void _cancelStream(ScheduledStream stream) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Cancel Stream',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to cancel "${stream.title}"? This action cannot be undone.',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Keep',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _scheduledStreams.removeWhere((s) => s.id == stream.id);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${stream.title} cancelled'),
                    backgroundColor: const Color(0xFFEF4444),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
              ),
              child: const Text(
                'Cancel Stream',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _goLiveNow(ScheduledStream stream) {
    // Navigate to live link page
    Navigator.pushReplacementNamed(
      context,
      '/live_link',
      arguments: {
        'title': stream.title,
        'description': '',
        'price': stream.price.toDouble(),
        'isInstant': true,
      },
    );
  }
}

class ScheduledStream {
  final String id;
  final String title;
  final int price;
  final DateTime scheduledDate;
  final TimeOfDay scheduledTime;
  final String status;

  ScheduledStream({
    required this.id,
    required this.title,
    required this.price,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.status,
  });
}
