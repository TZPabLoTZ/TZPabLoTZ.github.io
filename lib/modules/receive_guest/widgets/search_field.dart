import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';
import '../../../themes/app_styles.dart';
import '../receive_guest_controller.dart';

class SearchField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onSuffix;
  final Function()? onPrefix;
  final FocusNode? focusNode;

  const SearchField({
    super.key,
    required this.textController,
    required this.hintText,
    this.onChanged,
    this.onSuffix,
    this.onPrefix,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiveGuestController>(
      builder: (controller) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: screenWidth > 600 ? 500 : screenWidth * 0.9,
              constraints: const BoxConstraints(maxWidth: 600),
              child: TextField(
                focusNode: focusNode,
                onChanged: (value) => onChanged?.call(value),
                controller: textController,
                style: TextStyle(fontSize: screenWidth > 600 ? 16 : 14),
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: AppColors.white,
                  filled: true,
                  prefixIcon: onPrefix != null
                      ? IconButton(
                          onPressed: onPrefix,
                          color: AppColors.text,
                          icon: const Icon(Icons.search),
                        )
                      : const SizedBox.shrink(),
                  suffixIcon: onSuffix != null
                      ? InkWell(
                          onTap: () {
                            onSuffix!();
                            controller.clearSuggestions(textController);
                          },
                          child: const Icon(
                            Icons.delete_forever_sharp,
                            color: AppColors.text,
                          ),
                        )
                      : const SizedBox.shrink(),
                  contentPadding: const EdgeInsets.all(10),
                  hintStyle: const TextStyle(
                    color: AppColors.text,
                    fontFamily: 'Montserrat-italic',
                    fontSize: 12,
                  ),
                  border: AppStyles.outlineInputBorder,
                  enabledBorder: AppStyles.outlineInputBorder,
                  focusedBorder: AppStyles.outlineInputBorder,
                  hintText: hintText,
                ),
              ),
            ),
            if (focusNode!.hasFocus &&
                controller.showSuggestions &&
                controller.filteredSuggestions.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: screenWidth > 600 ? 500 : screenWidth * 0.9,
                  maxHeight: 200,
                ),
                child: Container(
                  width: screenWidth > 600 ? 500 : screenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: controller.filteredSuggestions.map(
                        (suggestion) {
                          return GestureDetector(
                            onTap: () {
                              textController.text = suggestion;
                              controller.showSuggestions = false;
                              onChanged?.call(suggestion);
                              controller.update();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                              child: Text(
                                suggestion,
                                style: TextStyle(
                                  fontSize: screenWidth > 600 ? 16 : 14,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
