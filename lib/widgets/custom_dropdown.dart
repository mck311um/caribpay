import 'package:caribpay/constants/values.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:caribpay/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/text_field/gf_text_field_rounded.dart';

class CustomDropdown<T> extends StatelessWidget {
  final double height;
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final String bottomSheetTitle;
  final List<T> items;
  final String Function(T) itemTextBuilder;
  final void Function(List<T>) onSelected;
  final bool enableMultipleSelection;
  final double maxChildSize;
  final double cornerRadius;
  final double borderWidth;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? labelPadding;
  final bool enabled;
  final bool isRequired;

  const CustomDropdown({
    super.key,
    this.height = 60,
    required this.controller,
    this.hintText = '',
    this.labelText = '',
    required this.bottomSheetTitle,
    required this.items,
    required this.itemTextBuilder,
    required this.onSelected,
    this.enableMultipleSelection = false,
    this.maxChildSize = 0.85,
    this.cornerRadius = 8.0,
    this.borderWidth = 1.0,
    this.labelStyle,
    this.labelPadding = const EdgeInsets.only(bottom: 8.0),
    this.enabled = true,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final disabledBorderColor = colorScheme.onSurface.withValues(alpha: 0.2);
    final disabledTextColor = colorScheme.onSurface.withValues(alpha: 0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText.isNotEmpty)
          Row(
            children: [
              Text(
                labelText,
                style: getTextStyle(
                  context,
                  16,
                  FontWeight.w600,
                  enabled
                      ? colorScheme.onSurface.withValues(alpha: 0.8)
                      : disabledTextColor,
                  TextDecoration.none,
                  FontStyle.normal,
                ),
              ),
            ],
          ),
        AbsorbPointer(
          absorbing: !enabled,
          child: SizedBox(
            height: 60,
            child: GFTextFieldRounded(
              marginhorizontal: 0,
              paddinghorizontal: 0,
              editingbordercolor:
                  enabled ? colorScheme.onSurface : disabledBorderColor,
              idlebordercolor:
                  enabled
                      ? colorScheme.onSurface.withValues(alpha: 0.5)
                      : disabledBorderColor,
              borderwidth: borderWidth,
              cornerradius: fBorderRadius * 2,
              hintText: hintText,
              showCursor: false,
              enabled: enabled,
              controller: controller,
              readOnly: true,
              style: getTextStyle(
                context,
                14,
                FontWeight.normal,
                enabled ? colorScheme.onSurface : disabledTextColor,
                TextDecoration.none,
                FontStyle.normal,
              ),
              onTap:
                  enabled
                      ? () {
                        DropDownState<T>(
                          dropDown: DropDown<T>(
                            isDismissible: true,
                            bottomSheetTitle: Text(
                              bottomSheetTitle,
                              style: getTextStyle(
                                context,
                                20,
                                FontWeight.w500,
                                colorScheme.onSurface,
                                TextDecoration.none,
                                FontStyle.normal,
                              ),
                            ),
                            dropDownPadding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.02,
                            ),
                            data:
                                items
                                    .map(
                                      (item) => SelectedListItem<T>(data: item),
                                    )
                                    .toList(),
                            listItemBuilder: (index, dataItem) {
                              return Text(
                                itemTextBuilder(dataItem.data),
                                style: getTextStyle(
                                  context,
                                  14,
                                  FontWeight.w500,
                                  colorScheme.onSurface,
                                  TextDecoration.none,
                                  FontStyle.normal,
                                ),
                              );
                            },
                            onSelected: (selectedItems) {
                              if (selectedItems.isNotEmpty) {
                                onSelected(
                                  selectedItems.map((e) => e.data).toList(),
                                );
                              } else {
                                controller.clear();
                              }
                            },
                            searchDelegate: (query, dataItems) {
                              return dataItems
                                  .where(
                                    (item) => itemTextBuilder(item.data)
                                        .toLowerCase()
                                        .contains(query.toLowerCase()),
                                  )
                                  .toList();
                            },
                            enableMultipleSelection: enableMultipleSelection,
                            maxSelectedItems:
                                enableMultipleSelection ? items.length : 1,
                            maxChildSize: maxChildSize,
                          ),
                        ).showModal(context);
                      }
                      : null,
            ),
          ),
        ),
      ],
    );
  }
}
