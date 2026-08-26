import 'package:flutter/material.dart';
import '../models/book.dart';

class ExchangeRequestScreen extends StatefulWidget {
  final Book book;

  const ExchangeRequestScreen({
    super.key,
    required this.book,
  });

  @override
  State<ExchangeRequestScreen> createState() =>
      _ExchangeRequestScreenState();
}

class _ExchangeRequestScreenState
    extends State<ExchangeRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _messageController =
      TextEditingController();

  final TextEditingController _bookOfferController =
      TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _bookOfferController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Exchange'),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                const Text(
                  'Request an Exchange',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Send a request to the owner of this book.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 24),

                // Requested book
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1E8DB),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 65,
                        height: 85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.menu_book_rounded,
                          size: 38,
                          color: Color(0xFF1E3A5F),
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.book.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1F2937),
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'by ${widget.book.author}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              widget.book.condition,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1E3A5F),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // Book you are offering
                const Text(
                  'Book You Want to Offer',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _bookOfferController,
                  decoration: _inputDecoration(
                    'e.g. Atomic Habits',
                    Icons.swap_horiz_rounded,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please enter a book you want to offer';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Message
                const Text(
                  'Message to Owner',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 8),

                TextFormField(
                  controller: _messageController,
                  maxLines: 5,
                  decoration: _inputDecoration(
                    'Write a message to the book owner...',
                    Icons.message_outlined,
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty) {
                      return 'Please write a message';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Send request
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton.icon(
                    onPressed: _sendRequest,
                    icon: const Icon(
                      Icons.send_rounded,
                    ),
                    label: const Text(
                      'Send Exchange Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sendRequest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Exchange request sent successfully!',
        ),
      ),
    );

    Navigator.pop(context);
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }
}