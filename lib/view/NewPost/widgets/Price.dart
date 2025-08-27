import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../controller/NewPostController.dart';
import 'Labelfield.dart';
import 'SectionCard.dart';
import 'SectionTitle.dart';

class PriceStep extends StatefulWidget {
  const PriceStep({super.key, required this.card, required this.controller});
  final Color card;
  final NewPostController controller;

  @override
  State<PriceStep> createState() => _PriceStepState();
}

class _PriceStepState extends State<PriceStep> {
  late TextEditingController textCtrl;

  @override
  void initState() {
    super.initState();
    textCtrl = TextEditingController(text: widget.controller.price.value);

    // Keep controller text in sync with observable
    ever(widget.controller.price, (val) {
      if (textCtrl.text != val) {
        textCtrl.text = val;
        textCtrl.selection = TextSelection.fromPosition(
          TextPosition(offset: textCtrl.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    textCtrl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final priceCtrl = TextEditingController(text: widget.controller.price.value);
    final textCtrl = TextEditingController(text: widget.controller.price.value);

    ever(widget.controller.price, (val) {
      if (textCtrl.text != val) {
        textCtrl.text = val;
      }
    });
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        children: [
          // First card - Price
          SectionCard(
            color: widget.card,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Set Your Price'),
                const SizedBox(height: 16),

                // Post Price row
                Obx(() {
                  double currentPrice = double.tryParse(widget.controller.price.value) ?? 35;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Post price',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        '₹${currentPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFFFFA21A),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 16),

                // Quick price buttons
                Obx(() {
                  double currentPrice = double.tryParse(widget.controller.price.value) ?? 35;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [15, 35, 50].map((price) {
                      bool selected = currentPrice == price;
                      return GestureDetector(
                        onTap: () {
                          widget.controller.price.value = price.toString();
                        },
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected ? const Color(0xFFFFA21A) : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selected ? Colors.transparent : Colors.white24,
                            ),
                          ),
                          child: Text(
                            '₹$price',
                            style: TextStyle(
                              color: selected ? Colors.black : Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),

                const SizedBox(height: 16),

                // Price Slider
                // Price Slider
                Obx(() {
                  double rawValue = double.tryParse(widget.controller.price.value) ?? 35;

                  // Clamp slider value between min and max to avoid crash
                  double sliderValue = rawValue.clamp(5, 100);

                  return Column(
                    children: [
                      Slider(
                        value: sliderValue,
                        min: 5,
                        max: 100,
                        divisions: 95,
                        activeColor: const Color(0xFFFFA21A),
                        inactiveColor: Colors.white12,
                        onChanged: (value) {
                          widget.controller.price.value = value.toStringAsFixed(0);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('₹5', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('₹100', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      )
                    ],
                  );
                }),

// Manual Input
              TextField(
                controller: textCtrl,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter custom price',
                  labelStyle: const TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xFF0B0F1A),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        color: Color(0xFFFFA21A), width: 1.2),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    widget.controller.price.value = value;
                  }
                },
              ),



                const SizedBox(height: 16),

                // Manual Input
                // Obx(() {
                //   final textCtrl =
                //   TextEditingController(text: controller.price.value.toString());
                //   return TextField(
                //     controller: textCtrl,
                //     style: const TextStyle(color: Colors.white),
                //     keyboardType: TextInputType.number,
                //     decoration: InputDecoration(
                //       labelText: 'Enter custom price',
                //       labelStyle: const TextStyle(color: Colors.white70),
                //       filled: true,
                //       fillColor: const Color(0xFF0B0F1A),
                //       contentPadding:
                //       const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //         borderSide: const BorderSide(color: Colors.white12),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //         borderSide: const BorderSide(color: Colors.white12),
                //       ),
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(12),
                //         borderSide:
                //         const BorderSide(color: Color(0xFFFFA21A), width: 1.2),
                //       ),
                //     ),
                //     onChanged: (value) {
                //       if (value.isNotEmpty) {
                //         controller.price.value = value;
                //       }
                //     },
                //   );
                // }),
              ],
            ),
          ),


          const SizedBox(height: 16),

          // Second card - Earnings Breakdown
          Obx(() {
            double price = double.tryParse(widget.controller.price.value) ?? 0;
            double fee = price * 0.1;
            double earnings = price - fee;

            return SectionCard(
              color: widget.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Earnings Breakdown'),
                  const SizedBox(height: 12),

                  // Your Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Your price',
                          style: TextStyle(color: Colors.white70)),
                      Text(
                        '₹${price.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Influbee Fee
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Influbee fee (10%)',
                          style: TextStyle(color: Colors.white70)),
                      Text(
                        '-₹${fee.toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12, height: 20),

                  // Final Earnings
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'You will earn',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '₹${earnings.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          // Third card - Additional Options
          const SizedBox(height: 16),

          Obx(() {
            return SectionCard(
              color: widget.card,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionTitle('Additional Options'),
                  const SizedBox(height: 12),

                  // Enable Comments
                  SwitchListTile(
                    value: widget.controller.enableComments.value,
                    activeColor: const Color(0xFFFFA21A),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Enable Comments',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Allow users to comment on this post',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    onChanged: (val) => widget.controller.enableComments.value = val,
                  ),

                  const Divider(color: Colors.white12, height: 12),

                  // Enable Likes
                  SwitchListTile(
                    value: widget.controller.enableLikes.value,
                    activeColor: const Color(0xFFFFA21A),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Enable Likes',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Show The Like Count On This Post',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    onChanged: (val) => widget.controller.enableLikes.value = val,
                  ),
                  SwitchListTile(
                    value: widget.controller.enableViews.value,
                    activeColor: const Color(0xFFFFA21A),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Enable Views',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Show The Views Count On This Post',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    onChanged: (val) => widget.controller.enableViews.value = val,
                  ),
                  SwitchListTile(
                    value: widget.controller.AgeRestriction.value,
                    activeColor: const Color(0xFFFFA21A),
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Age Restrictions',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: const Text(
                      'Only Available For 18+',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    onChanged: (val) => widget.controller.AgeRestriction.value = val,
                  ),
                ],
              ),
            );
          }),

        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFF0B0F1A),
    contentPadding:
    const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white12),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide:
      const BorderSide(color: Color(0xFFFFA21A), width: 1.2),
    ),
  );
}
