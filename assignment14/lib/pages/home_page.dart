import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/hotel_bloc.dart';
import '../bloc/hotel_event.dart';
import '../bloc/hotel_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _bounceController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _priceController = TextEditingController(text: '1');
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HotelBloc, HotelState>(
      listener: (context, state) {
        if (state.isBookingAnimating) {
          _bounceController.forward().then((_) {
            _bounceController.reverse();
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F8),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {},
                    ),
                    const Text(
                      'Smart Hotel Booking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A202C),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<HotelBloc, HotelState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              context.read<HotelBloc>().add(
                                const ToggleCardExpanded(),
                              );
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                              height: state.isCardExpanded ? 420 : 178,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    height: 178,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/hotel.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  if (state.isCardExpanded)
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                         Row(
                                            children: [
                                              Text(
                                                'Grand Hyatt Manila',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                               Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  239,
                                                  59,
                                                ),
                                              ),
                                               Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  239,
                                                  59,
                                                ),
                                              ),
                                               Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  239,
                                                  59,
                                                ),
                                              ),
                                               Icon(
                                                Icons.star,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  239,
                                                  59,
                                                ),
                                              ),
                                               Icon(
                                                Icons.star_border_outlined,
                                                color: Color.fromARGB(
                                                  255,
                                                  255,
                                                  239,
                                                  59,
                                                ),
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 6),

                                          Text(
                                            'Deluxe King Room ',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),

                                          SizedBox(height: 10),

                                          Text(
                                            'Dulexe King Room a to din | Ansor',
                                            style: TextStyle(fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<HotelBloc, HotelState>(
                        builder: (context, state) {
                          return Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<HotelBloc>().add(
                                        const SwitchTab('offers'),
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: state.activeTab == 'offers'
                                            ? const Color(0xFF1975D2)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Offers',
                                          style: TextStyle(
                                            color: state.activeTab == 'offers'
                                                ? Colors.white
                                                : const Color(0xFF64748B),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<HotelBloc>().add(
                                        const SwitchTab('reviews'),
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: state.activeTab == 'reviews'
                                            ? const Color(0xFF1975D2)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Guest Reviews',
                                          style: TextStyle(
                                            color: state.activeTab == 'reviews'
                                                ? Colors.white
                                                : const Color(0xFF64748B),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<HotelBloc, HotelState>(
                        builder: (context, state) {
                          return AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: state.activeTab == 'offers'
                                ? Container(
                                    key: const ValueKey('offers'),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/hotel room.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(32),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          '20% off this weekend!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Book now and save big on your stay.',
                                          style: TextStyle(
                                            color: Colors.white.withValues(
                                              alpha: 0.8,
                                            ),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    key: const ValueKey('reviews'),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  '- Sarah M.',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                Spacer(),

                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star_border_outlined,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star_border_outlined,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 10),

                                            const Text(
                                              'Excellent service and beautiful rooms!',
                                              style: TextStyle(
                                                color: Color(0xFF64748B),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  '- John K.',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),

                                                Spacer(),

                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.star_border_outlined,
                                                  color: Color.fromARGB(
                                                    255,
                                                    62,
                                                    255,
                                                    59,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            const SizedBox(height: 10),

                                            const Text(
                                              'To7fa',
                                              style: TextStyle(
                                                color: Color(0xFF64748B),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Price Range:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A202C),
                        ),
                      ),
                      const SizedBox(height: 16),

                      BlocBuilder<HotelBloc, HotelState>(
                        builder: (context, state) {
                          _priceController.text = state.priceValue.toString();
                          return TextField(
                            controller: _priceController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              final price = int.tryParse(value) ?? 1;
                              context.read<HotelBloc>().add(UpdatePrice(price));
                            },
                            decoration: InputDecoration(
                              prefixText: '\$ ',
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.trending_up),
                                onPressed: () {},
                              ),
                              filled: true,
                              fillColor: const Color(0xFFF6F7F8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCBD5E1),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFFCBD5E1),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: const BorderSide(
                                  color: Color(0xFF1975D2),
                                  width: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<HotelBloc, HotelState>(
                        builder: (context, state) {
                          return Column(
                            children: [
                              Slider(
                                value: state.priceValue.toDouble(),
                                min: 1,
                                max: 10000,
                                onChanged: (value) {
                                  context.read<HotelBloc>().add(
                                    UpdatePrice(value.toInt()),
                                  );
                                },
                                activeColor: const Color(0xFF1975D2),
                                inactiveColor: const Color(0xFFE2E8F0),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      '\$1',
                                      style: TextStyle(
                                        color: Color(0xFF64748B),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '\$10k',
                                      style: TextStyle(
                                        color: Color(0xFF64748B),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F8),
                  border: Border(top: BorderSide(color: Colors.grey.shade200)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    BlocBuilder<HotelBloc, HotelState>(
                      builder: (context, state) {
                        return ScaleTransition(
                          scale: Tween<double>(begin: 1, end: 0.95).animate(
                            CurvedAnimation(
                              parent: _bounceController,
                              curve: Curves.easeInOut,
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<HotelBloc>().add(
                                const TriggerBookingAnimation(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1975D2),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(double.infinity, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 2,
                            ),
                            child: const Text(
                              'Book Now',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(Icons.home, 'Home', true),
                        _buildNavItem(Icons.calendar_today, 'Bookings', false),
                        _buildNavItem(Icons.favorite, 'Favorites', false),
                        _buildNavItem(Icons.person, 'Profile', false),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF1975D2) : const Color(0xFF64748B),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: isActive ? const Color(0xFF1975D2) : const Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
