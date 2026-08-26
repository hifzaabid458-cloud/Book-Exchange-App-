import 'package:flutter/material.dart';

class ExchangeRequestsScreen extends StatefulWidget {
  const ExchangeRequestsScreen({super.key});

  @override
  State<ExchangeRequestsScreen> createState() =>
      _ExchangeRequestsScreenState();
}

class _ExchangeRequestsScreenState extends State<ExchangeRequestsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> incomingRequests = [
    {
      'name': 'Ali Butt',
      'book': 'Atomic Habits',
      'offeredBook': 'The Alchemist',
      'status': 'Pending',
    },
    {
      'name': 'Ayesha Hashmi',
      'book': 'Clean Code',
      'offeredBook': 'Rich Dad Poor Dad',
      'status': 'Pending',
    },
  ];

  final List<Map<String, dynamic>> sentRequests = [
    {
      'owner': 'Hassan Akbar',
      'book': 'The Psychology of Money',
      'offeredBook': 'Atomic Habits',
      'status': 'Pending',
    },
    {
      'owner': 'Sundas Ali',
      'book': 'Deep Work',
      'offeredBook': 'The Alchemist',
      'status': 'Accepted',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _acceptRequest(int index) {
    setState(() {
      incomingRequests[index]['status'] = 'Accepted';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exchange request accepted!'),
      ),
    );
  }

  void _rejectRequest(int index) {
    setState(() {
      incomingRequests[index]['status'] = 'Rejected';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exchange request rejected.'),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Accepted':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exchange Requests',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          tabs: const [
            Tab(text: 'Incoming'),
            Tab(text: 'Sent'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIncomingRequests(),
          _buildSentRequests(),
        ],
      ),
    );
  }

  Widget _buildIncomingRequests() {
    if (incomingRequests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.inbox_outlined,
        title: 'No Incoming Requests',
        subtitle: 'You have no exchange requests yet.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: incomingRequests.length,
      itemBuilder: (context, index) {
        final request = incomingRequests[index];
        final status = request['status'];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Text(
                        request['name'][0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'wants to exchange books',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(status),
                  ],
                ),

                const SizedBox(height: 18),

                _buildBookRow(
                  icon: Icons.menu_book,
                  title: 'Your Book',
                  bookName: request['book'],
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Icon(
                    Icons.swap_vert,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 10),

                _buildBookRow(
                  icon: Icons.bookmark,
                  title: 'Offered Book',
                  bookName: request['offeredBook'],
                ),

                if (status == 'Pending') ...[
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _rejectRequest(index),
                          icon: const Icon(Icons.close),
                          label: const Text('Reject'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _acceptRequest(index),
                          icon: const Icon(Icons.check),
                          label: const Text('Accept'),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSentRequests() {
    if (sentRequests.isEmpty) {
      return _buildEmptyState(
        icon: Icons.send_outlined,
        title: 'No Sent Requests',
        subtitle: 'You havenot sent any exchange requests.',
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sentRequests.length,
      itemBuilder: (context, index) {
        final request = sentRequests[index];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Text(
                        request['owner'][0],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        request['owner'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _buildStatusChip(request['status']),
                  ],
                ),

                const SizedBox(height: 18),

                _buildBookRow(
                  icon: Icons.menu_book,
                  title: 'Requested Book',
                  bookName: request['book'],
                ),

                const SizedBox(height: 10),

                const Center(
                  child: Icon(
                    Icons.swap_vert,
                    size: 28,
                  ),
                ),

                const SizedBox(height: 10),

                _buildBookRow(
                  icon: Icons.bookmark,
                  title: 'Your Offered Book',
                  bookName: request['offeredBook'],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBookRow({
    required IconData icon,
    required String title,
    required String bookName,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  bookName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    return Chip(
      label: Text(
        status,
        style: TextStyle(
          color: _statusColor(status),
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
      backgroundColor: _statusColor(status).withOpacity(0.1),
      side: BorderSide.none,
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 70,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}