import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String selectedLocation = 'Sarai Alamgir';
  bool isLoading = true;

  final List<String> locations = [
    'Sarai Alamgir',
    'Gujrat',
    'Gujranwala',
    'Lahore',
    'Islamabad',
    'Faisalabad',
    'Rawalpindi',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  // ============================================================
  // LOAD SAVED LOCATION
  // ============================================================

  Future<void> _loadLocation() async {
    final prefs = await SharedPreferences.getInstance();

    final savedLocation =
    prefs.getString('user_location');

    if (!mounted) return;

    if (savedLocation != null &&
        locations.contains(savedLocation)) {
      setState(() {
        selectedLocation = savedLocation;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  // ============================================================
  // SAVE LOCATION
  // ============================================================

  Future<void> _saveLocation() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'user_location',
      selectedLocation,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Location updated to $selectedLocation',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Location',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // ==================== ICON ====================

              Icon(
                Icons.location_on_rounded,
                size: 55,
                color: Theme.of(context)
                    .colorScheme
                    .primary,
              ),

              const SizedBox(height: 16),

              // ==================== TITLE ====================

              const Text(
                'Choose Your Location',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              // ==================== DESCRIPTION ====================

              const Text(
                'Select your preferred location to find books '
                    'available for exchange nearby.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 25),

              // ==================== LABEL ====================

              const Text(
                'Your Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              // ==================== DROPDOWN ====================

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius:
                  BorderRadius.circular(14),
                ),
                child:
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLocation,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: locations.map(
                          (location) {
                        return DropdownMenuItem<
                            String>(
                          value: location,
                          child: Row(
                            children: [
                              const Icon(
                                Icons
                                    .location_on_outlined,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(location),
                            ],
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedLocation =
                              value;
                        });
                      }
                    },
                  ),
                ),
              ),

              const Spacer(),

              // ==================== SAVE BUTTON ====================

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: _saveLocation,
                  icon: const Icon(
                    Icons.check,
                  ),
                  label: const Text(
                    'Save Location',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}